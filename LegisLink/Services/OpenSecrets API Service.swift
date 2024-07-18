//
//  OpenSecrets API Service.swift
//  town square
//
//  Created by Mason Cochran on 8/4/23.
//

import Foundation



protocol OpenSecretsServiceProtocol {
    func getTopContributors(from openSecretsID: String, url: URL, completion: @escaping (Swift.Result<Contributors, Error>) -> Void)
    func formatStringValuesToUSDCurrency(contributors: inout Contributors) -> Contributors
    func getOpenSecretsAPIURLs(official: Official) -> [URL]

}



class OpenSecretsService: OpenSecretsServiceProtocol {

    
    private var openSecretsAPIKey: String {
        get {return Environment.openSecretsAPI}
    }
    
    
    
    func getTopContributors(from openSecretsID: String, url: URL, completion: @escaping (Swift.Result<Contributors, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { [self] (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            do {
                var contributors = try JSONDecoder().decode(Contributors.self, from: data)
                contributors = formatStringValuesToUSDCurrency(contributors: &contributors)
                completion(.success(contributors))
            } catch {
                let returnString = String(data: data, encoding: .utf8)
                if (returnString == "Resource not found") {
                    var fakeContributor = Contributors(
                    response: Response(
                    contributors: ContributorsClass(
                    attributes: ContributorsAttributes(
                    candName: "0", cid: openSecretsID, cycle: "0", origin: "0", source: "0", notice: "0"
                    ),
                    contributor: [Contributor(attributes: ContributorAttributes(orgName: "0", total: "0", pacs: "0", indivs: "0"))]
                    )))
                    let stringURL = url.absoluteString
                    
                    if (stringURL.contains("2012")) {fakeContributor.response.contributors.attributes.cycle = "2012"}
                    
                    else if (stringURL.contains("2014")) {fakeContributor.response.contributors.attributes.cycle = "2014"}
                    
                    else if (stringURL.contains("2016")) {fakeContributor.response.contributors.attributes.cycle = "2016"}
                    
                    else if (stringURL.contains("2018")) {fakeContributor.response.contributors.attributes.cycle = "2018"}
                    
                    else if (stringURL.contains("2020")) {fakeContributor.response.contributors.attributes.cycle = "2020"}
                    
                    else {fakeContributor.response.contributors.attributes.cycle = "2022"}
                    
                    completion(.success(fakeContributor))
                
                }
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    func formatStringValuesToUSDCurrency(contributors: inout Contributors) -> Contributors {
        let formatter = NumberFormatter()

        for index in contributors.response.contributors.contributor.indices {
            formatter.numberStyle = .currency
            
            var doubleVersion = Double(contributors.response.contributors.contributor[index].attributes.total)
            
            let formattedValue = formatter.string(for: doubleVersion)
            
            
            contributors.response.contributors.contributor[index].attributes.total = formattedValue!
        }
        return contributors
    }
    
    func getOpenSecretsAPIURLs(official: Official) -> [URL] {
        
        var openSecretsURLs = [URL]()


        
        let contributionYears = ["2012", "2014", "2016", "2018", "2020", "2022"]
        
        
        for year in contributionYears {
            let officialContributionURL = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(official.opensecretsID!)&cycle=\(year)&apikey=\(openSecretsAPIKey)&output=json")
            
            openSecretsURLs.append(officialContributionURL!)
            
        }
        
        
        return openSecretsURLs
        
    }
    
}

