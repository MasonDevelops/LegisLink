//
//  MyRepsViewModel.swift
//  town square
//
//  Created by Mason Cochran on 5/25/23.
//

import Foundation



import Fuse
import Yams


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
         ocdID: "ocdID", bioguideID: "bioguideID", govtrackID: "govtrackID", wikidataID: "wikidataID", votesmartID: "votesmartID", fecID: "fecID",
         contributors: [Contributor(attributes: ContributorAttributes(orgName: "orgName", total: "total", pacs: "pacs", indivs: "indivs"))],
         committees: ["committees"])
    
    @Published var senatorTwo = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
         )],
         ocdID: "ocdID", bioguideID: "bioguideID", govtrackID: "govtrackID", wikidataID: "wikidataID", votesmartID: "votesmartID", fecID: "fecID",
         contributors: [Contributor(attributes: ContributorAttributes(orgName: "orgName", total: "total", pacs: "pacs", indivs: "indivs"))],
         committees: ["committees"])
    
    @Published var representative = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                             
         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
         )],
         ocdID: "ocdID", bioguideID: "bioguideID", govtrackID: "govtrackID", wikidataID: "wikidataID", votesmartID: "votesmartID", fecID: "fecID",
         contributors: [Contributor(attributes: ContributorAttributes(orgName: "orgName", total: "total", pacs: "pacs", indivs: "indivs"))],
         committees: ["committees"])
    
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
                bundleOpenStatesData()
                getTopSixContributorInfo()
                parseSenateCommitteeLists()
                parseHouseCommitteeLists()
                
                
                
            }
        }
        .resume()
    }
    
    
    func fetchOpenStatesOfficialData() -> [CandidateYAML] {
        let fm = FileManager.default
        let path = "/Users/mcmacbookair/Desktop/us/legislature/"
        var membersOfCongress = [CandidateYAML]()
        
        
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                let filePath = path + item
                let contents = try String(contentsOfFile: filePath)
                let decoder = YAMLDecoder()
                let decoded = try decoder.decode(CandidateYAML.self, from: contents)
                membersOfCongress.append(decoded)
            }
        } catch {
            print("Error info: \(error)")
        }
        
        return membersOfCongress
    }
    
    
    func bundleOpenStatesData() {
        let candidates = fetchOpenStatesOfficialData()
        let ocdIDCollection = fuzzySearch(candidates: candidates)
        senatorOne.ocdID = ocdIDCollection[0]
        senatorTwo.ocdID = ocdIDCollection[1]
        representative.ocdID = ocdIDCollection[2]
        
        for candidate in candidates {
            if senatorOne.ocdID == candidate.id {
                for other_id in candidate.otherIdentifiers {
                    if other_id.scheme == "bioguide" {
                        senatorOne.bioguideID = other_id.identifier
                    } else if other_id.scheme == "govtrack" {
                        senatorOne.govtrackID = other_id.identifier
                    } else if other_id.scheme == "opensecrets" {
                        senatorOne.opensecretsID = other_id.identifier
                    } else if other_id.scheme == "votesmart" {
                        senatorOne.votesmartID = other_id.identifier
                    } else if other_id.scheme == "fec" {
                        senatorOne.fecID = other_id.identifier
                    } else if other_id.scheme == "wikidata" {
                        senatorOne.wikidataID = other_id.identifier
                    } else {
                        continue
                    }
                }
            }
        }
        for candidate in candidates {
            if senatorTwo.ocdID == candidate.id {
                for other_id in candidate.otherIdentifiers {
                    if other_id.scheme == "bioguide" {
                        senatorTwo.bioguideID = other_id.identifier
                    } else if other_id.scheme == "govtrack" {
                        senatorTwo.govtrackID = other_id.identifier
                    } else if other_id.scheme == "opensecrets" {
                        senatorTwo.opensecretsID = other_id.identifier
                    } else if other_id.scheme == "votesmart" {
                        senatorTwo.votesmartID = other_id.identifier
                    } else if other_id.scheme == "fec" {
                        senatorTwo.fecID = other_id.identifier
                    } else if other_id.scheme == "wikidata" {
                        senatorTwo.wikidataID = other_id.identifier
                    } else {
                        continue
                    }
                    
                }
            }
        }
        for candidate in candidates {
            if representative.ocdID == candidate.id {
                for other_id in candidate.otherIdentifiers {
                    if other_id.scheme == "bioguide" {
                        representative.bioguideID = other_id.identifier
                    } else if other_id.scheme == "govtrack" {
                        representative.govtrackID = other_id.identifier
                    } else if other_id.scheme == "opensecrets" {
                        representative.opensecretsID = other_id.identifier
                    } else if other_id.scheme == "votesmart" {
                        representative.votesmartID = other_id.identifier
                    } else if other_id.scheme == "fec" {
                        representative.fecID = other_id.identifier
                    } else if other_id.scheme == "wikidata" {
                        representative.wikidataID = other_id.identifier
                    } else {
                        continue
                    }
                    
                }
            }
        }
    }
    
    
    func fuzzySearch(candidates: [CandidateYAML]) -> [String] {
        var currentLawmakers = [Official]()
        currentLawmakers.append(self.senatorOne)
        currentLawmakers.append(self.senatorTwo)
        currentLawmakers.append(self.representative)
        
        var ocdIDArray = [String]()
        
        var best_score = 150.0
        var best_match_id = ""
        let removeCharacters: Set<Character> = [".", ","]
        
        let fuse = Fuse()
        
        for var lawmaker in currentLawmakers {
            best_score = 150.0
            lawmaker.name.removeAll(where: { removeCharacters.contains($0)})
            let lawmakerPattern = fuse.createPattern(from: lawmaker.name)
            candidates.forEach {
                let result = fuse.search(lawmakerPattern, in: $0.name)
                if (result?.score != nil){
                    if (result!.score < best_score){
                        best_score = result!.score
                        best_match_id = $0.id
                    }
                }
                
            }
            ocdIDArray.append(best_match_id)
        }
        return ocdIDArray
    }
    
    
    
    func getTopSixContributorInfo() {
        let openSecretsAPIKey = ProcessInfo.processInfo.environment["OpenSecrets_API_Key"]
        
        guard let url = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.senatorOne.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json") else { return }
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
        guard let url = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.senatorTwo.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json") else { return }
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
        guard let url = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.representative.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json") else { return }
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
    
    func getMaxSenateCommitteePages(completion: @escaping (Int) -> Void) {
        let openStatesAPIKey = ProcessInfo.processInfo.environment["OpenStates_API_Key"]
        guard let url = URL(string: "https://v3.openstates.org/committees?jurisdiction=ocd-jurisdiction%2Fcountry%3Aus%2Fgovernment&classification=committee&chamber=upper&include=memberships&apikey=\(openStatesAPIKey!)&page=1&per_page=20")
        else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let senateCommitteeList = try JSONDecoder().decode(CommitteeList.self, from: data)
                let maxPage = senateCommitteeList.pagination.maxPage
                return completion(maxPage)
                
            } catch {
                print("Unexpected error: \(error).")
            }
        }.resume()
    }
    
    func getSenateCommittees(currentPage: Int, completion: @escaping (CommitteeList?) -> Void) {
        let openStatesAPIKey = ProcessInfo.processInfo.environment["OpenStates_API_Key"]
        guard let url = URL(string: "https://v3.openstates.org/committees?jurisdiction=ocd-jurisdiction%2Fcountry%3Aus%2Fgovernment&classification=committee&chamber=upper&include=memberships&apikey=\(openStatesAPIKey!)&page=\(currentPage)&per_page=20")
        else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let senateCommitteeList = try JSONDecoder().decode(CommitteeList.self, from: data)
                completion(senateCommitteeList)
                
            } catch {
                print("Unexpected error: \(error).")
            }
        }.resume()
    }
    
    
    func parseSenateCommitteeLists() {
        let group = DispatchGroup()
        let maxPageGroup = DispatchGroup()
        var currentPage = 1
        var maxPage = 0
        
        maxPageGroup.enter()
        getMaxSenateCommitteePages { maxPageCallVal in
            maxPage = maxPageCallVal
            maxPageGroup.leave()
        }
        
        maxPageGroup.wait()
        maxPageGroup.notify(queue: DispatchQueue.main) {
            print("Maximum page for Senate Committee API Call complete. Value is \(maxPage)")
        }
        while currentPage <= maxPage {
            group.enter()
            getSenateCommittees(currentPage: currentPage) { [self] (currList) in
                for results in currList!.results {
                    for memberships in results.memberships {
                        if (self.senatorOne.ocdID == memberships.person.id) {
                            self.senatorOne.committees?.append(results.name) ?? (self.senatorOne.committees = [results.name])
                        }
                        if (self.senatorTwo.ocdID == memberships.person.id) {
                            self.senatorTwo.committees?.append(results.name) ?? (self.senatorTwo.committees = [results.name])
                        }
                        
                    }
                }
                currentPage = currentPage + 1
                group.leave()
            }
            group.wait()
        }
        group.notify(queue: DispatchQueue.main) {
            print("Senate committees found")
        }
    }
    
    func getMaxHouseCommitteePages(completion: @escaping (Int) -> Void) {
        let openStatesAPIKey = ProcessInfo.processInfo.environment["OpenStates_API_Key"]
        guard let url = URL(string: "https://v3.openstates.org/committees?jurisdiction=ocd-jurisdiction%2Fcountry%3Aus%2Fgovernment&classification=committee&chamber=lower&include=memberships&apikey=\(openStatesAPIKey!)&page=1&per_page=20")
        else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let houseCommitteeList = try JSONDecoder().decode(CommitteeList.self, from: data)
                let maxPage = houseCommitteeList.pagination.maxPage
                return completion(maxPage)
                
            } catch {
                print("Unexpected error: \(error).")
            }
        }.resume()
    }
    
    
    
    
    
    func getHouseCommittees(currentPage: Int, completion: @escaping (CommitteeList?) -> Void) {
        let openStatesAPIKey = ProcessInfo.processInfo.environment["OpenStates_API_Key"]
        guard let url = URL(string: "https://v3.openstates.org/committees?jurisdiction=ocd-jurisdiction%2Fcountry%3Aus%2Fgovernment&classification=committee&chamber=lower&include=memberships&apikey=\(openStatesAPIKey!)&page=\(currentPage)&per_page=20")
        else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do {
                let houseCommitteeList = try JSONDecoder().decode(CommitteeList.self, from: data)
                completion(houseCommitteeList)
                
            } catch {
                print("Unexpected error: \(error).")
            }
        }.resume()
    }
    
    
    
    func parseHouseCommitteeLists() {
        let group = DispatchGroup()
        let maxPageGroup = DispatchGroup()
        var currentPage = 1
        var maxPage = 2
        
        maxPageGroup.enter()
        getMaxHouseCommitteePages { maxPageCallVal in
            maxPage = maxPageCallVal
            maxPageGroup.leave()
        }
        
        maxPageGroup.wait()
        maxPageGroup.notify(queue: DispatchQueue.main) {
            print("Maximum page for House Committee API Call complete. Value is \(maxPage)")
        }
        while currentPage <= maxPage {
            group.enter()
            getHouseCommittees(currentPage: currentPage) { [self] (currList) in
                for results in currList!.results {
                    for memberships in results.memberships {
                        if (self.representative.ocdID == memberships.person.id) {
                            self.representative.committees?.append(results.name) ?? (self.representative.committees = [results.name])
                        }
                    }
                }
                currentPage = currentPage + 1
                group.leave()
            }
            group.wait()
        }
        group.notify(queue: DispatchQueue.main) {
            print("House committees found")
        }
    }
}
