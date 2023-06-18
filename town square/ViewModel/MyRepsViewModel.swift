//
//  MyRepsViewModel.swift
//  town square
//
//  Created by Mason Cochran on 5/25/23.
//

import Foundation



import Fuse


class MyRepsViewModel: ObservableObject {
    
    private var user: User
    
    @Published var senatorOne = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
         )],
         crpCandidateID: "crpCandidateID",
         contributors: [Contributor(attributes: ContributorAttributes(orgName: "orgName", total: "total", pacs: "pacs", indivs: "indivs"))])
    
    
    @Published var senatorTwo = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
         )],
         crpCandidateID: "crpCandidateID",
         contributors: [Contributor(attributes: ContributorAttributes(orgName: "orgName", total: "total", pacs: "pacs", indivs: "indivs"))])
    
    @Published var representative = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                             
         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
         )],
         crpCandidateID: "crpCandidateID",
         contributors: [Contributor(attributes: ContributorAttributes(orgName: "orgName", total: "total", pacs: "pacs", indivs: "indivs"))])
    
    init(user: User){
        self.user = user
        getReps()
        
    }
    
    func getReps() {
        let gapiKey = ProcessInfo.processInfo.environment["Google_API_Key"]
        let fullAddress = user.returnFullAddress()
        let fullAddressEncoded = fullAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: "https://www.googleapis.com/civicinfo/v2/representatives?key=\(gapiKey!)&address=\(fullAddressEncoded!)&includedOffices=true&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let lawmakers = try JSONDecoder().decode(Reps.self, from: data)
                
                self.senatorOne = lawmakers.officials[0]
                
                if (self.senatorOne.photoURL == nil) {
                    self.senatorOne.photoURL = "photoURL"
                }
                
                self.senatorTwo = lawmakers.officials[1]
                
                if (self.senatorTwo.photoURL == nil) {
                    self.senatorTwo.photoURL = "photoURL"
                }
                
                self.representative = lawmakers.officials[2]
                
                if (self.representative.photoURL == nil) {
                    self.representative.photoURL = "photoURL"
                }
            } catch {
                print("Unexpected error: \(error).")
            }
            
            DispatchQueue.main.async { [self] in
                bundleCID()
                getTopSixContributorInfo()
                
                
            }
        }
        .resume()
    }
    
    func readCRPCandidateJSON() -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: "117_congress_master_list", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parseCRPCandidateJSON(jsonData: Data) -> [CRPCandidateElement]? {
        do {
            let decodedData = try JSONDecoder().decode([CRPCandidateElement].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func bundleCID() {
        if let candidateData = readCRPCandidateJSON() {
            if let candidates = parseCRPCandidateJSON(jsonData: candidateData) {
                let cIDCollection = fuzzySearch(candidates: candidates)
                senatorOne.crpCandidateID = cIDCollection[0]
                senatorTwo.crpCandidateID = cIDCollection[1]
                representative.crpCandidateID = cIDCollection[2]
            }
        }
    }
    
    func fuzzySearch(candidates: [CRPCandidateElement]) -> [String] {
        var currentLawmakers = [Official]()
        currentLawmakers.append(self.senatorOne)
        currentLawmakers.append(self.senatorTwo)
        currentLawmakers.append(self.representative)
        
        var cIDArray = [String]()
        
        var best_score = 150.0
        var best_match_id = ""
        let removeCharacters: Set<Character> = [".", ","]
        
        let fuse = Fuse()
        
        for var lawmaker in currentLawmakers {
            best_score = 150.0
            lawmaker.name.removeAll(where: { removeCharacters.contains($0)})
            let lawmakerPattern = fuse.createPattern(from: lawmaker.name)
            candidates.forEach {
                let result = fuse.search(lawmakerPattern, in: $0.crpName)
                if (result?.score != nil){
                    if (result!.score < best_score){
                        best_score = result!.score
                        best_match_id = $0.cid
                    }
                }
                
            }
            cIDArray.append(best_match_id)
        }
        return cIDArray
    }
    
    
    
    func getTopSixContributorInfo() {
        let openSecretsAPIKey = ProcessInfo.processInfo.environment["OpenSecrets_API_Key"]
        
        guard let url = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.senatorOne.crpCandidateID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else {return}
                do {
                    let contributors = try? JSONDecoder().decode(Contributors.self, from: data)
                    self.senatorOne.contributors = contributors!.response.contributors.contributor
                } catch {
                    print("Unexpected error: \(error).")
                }
            }
            .resume()
        guard let url = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.senatorTwo.crpCandidateID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else {return}
                do {
                    let contributors = try? JSONDecoder().decode(Contributors.self, from: data)
                    self.senatorTwo.contributors = contributors!.response.contributors.contributor
                } catch {
                    print("Unexpected error: \(error).")
                }
            }
            .resume()
        guard let url = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.representative.crpCandidateID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else {return}
                do {
                    let contributors = try? JSONDecoder().decode(Contributors.self, from: data)
                    self.representative.contributors = contributors!.response.contributors.contributor
                } catch {
                    print("Unexpected error: \(error).")
                }
            }
            .resume()
        }
}
