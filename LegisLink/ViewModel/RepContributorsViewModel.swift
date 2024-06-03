//
//  RepContributorsViewModel.swift
//  LegisLink
//
//  Created by Mason Cochran on 12/30/23.
//

import Foundation



class RepContributorsViewModel: ObservableObject {
    
    private var user: User
    private let openSecretsService: OpenSecretsServiceProtocol
    @Published var official: Official

    init(user: User, openSecretsService: OpenSecretsServiceProtocol, official: Official) {
        self.user = user
        self.openSecretsService = openSecretsService
        self.official = official
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            let jm2020 = URL(string: "jerry-moran-2020-contributors")
            let jm2022 = URL(string: "jerry-moran-2022-contributors")
            let jm2012 = URL(string: "jerry-moran-2012-contributors")


            var testURLs = [URL]()
            testURLs.append(jm2020!)
            testURLs.append(jm2022!)
            testURLs.append(jm2012!)

            
            getTopContributorInfo(openSecretsURLs: testURLs)
            
        } else {
            let openSecretsURLs = getOpenSecretsAPIURLs()
            getTopContributorInfo(openSecretsURLs: openSecretsURLs)
        }
        
    }
    
    
    func getTopContributorInfo(openSecretsURLs: [URL]) {
        
        let group = DispatchGroup()
        
        for currentURL in openSecretsURLs {
            
            group.enter()
            
            openSecretsService.getTopContributors(from: currentURL) { [weak self] result in
                
                switch result {
                case .success(let contributors):
                    if (self!.official.opensecretsID == contributors.response.contributors.attributes.cid) {
                        switch contributors.response.contributors.attributes.cycle {
                        case "2012":
                            self!.official.twentyTwelveContributors = contributors.response.contributors.contributor
                        case "2016":
                            self!.official.twentySixTeenContributors = contributors.response.contributors.contributor
                        case "2018":
                            self!.official.twentyEightTeenContributors = contributors.response.contributors.contributor
                        case "2020":
                            self!.official.twentyTwentyContributors = contributors.response.contributors.contributor
                        case "2022":
                            self!.official.twentyTwentyTwoContributors = contributors.response.contributors.contributor
                        default:
                            break
                        }
                    }
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
                group.leave()
            }
            group.wait()
            
        }
        group.notify(queue: DispatchQueue.main) {
            print("All calls have completed.")
        }
    }
    
    
    func getOpenSecretsAPIURLs() -> [URL] {
        
        let openSecretsAPIKey = Environment.openSecretsAPI
        var openSecretsURLs = [URL]()


        
        let contributionYears = ["2012", "2014", "2016", "2018", "2020", "2022"]
        
        for year in contributionYears {
            let officialContributionURL = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.official.opensecretsID!)&cycle=\(year)&apikey=\(openSecretsAPIKey)&output=json")
            
            openSecretsURLs.append(officialContributionURL!)
            
        }
        
        
        return openSecretsURLs
        
    }
}







