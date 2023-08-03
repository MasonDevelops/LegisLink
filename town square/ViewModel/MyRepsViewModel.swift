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
         )])
         
    
    @Published var senatorTwo = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
         )])
    
    @Published var representative = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                             
         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
            type: "type",
            id: "id"
         )])
    
    init(user: User){
        self.user = user
        let googleCivicInfoURL = getGoogleCivicInformationAPIURL()
        getReps(googleCivicInfoURL: googleCivicInfoURL)
        bundleOpenStatesData()
        let openSecretsAPIURls = getOpenSecretsAPIURLs()
        getTopSixContributorInfo(openSecretsURLs: openSecretsAPIURls)
        parseSenateCommitteeLists()
        parseHouseCommitteeLists()
        
    }
    
    func getGoogleCivicInformationAPIURL() -> URL {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            let bundle = Bundle(for: MyRepsViewModel.self)
            let path = bundle.path(forResource: "successful-google-civic-info-api-response", ofType: "json")
            let url = URL(fileURLWithPath: path!)

            
            return url
        } else {
            let googleCivicInformationAPIKey = ProcessInfo.processInfo.environment["Google_API_Key"]
            let fullAddress = user.returnFullAddress()
            let fullAddressEncoded = fullAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let urlPath = "https://www.googleapis.com/civicinfo/v2/representatives?key=\(googleCivicInformationAPIKey!)&address=\(fullAddressEncoded!)&includedOffices=true&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody"
            
            let url = URL(string: urlPath)



            return url!
        }
    }
    
    func getOpenSecretsAPIURLs() -> [URL] {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            let bundle = Bundle(for: MyRepsViewModel.self)
            var testOpenSecretsURLs = [URL]()
            
            for currentResponse in 1...3 {
                let path = bundle.path(forResource: "successful-open-secrets-api-response-\(currentResponse)", ofType: "json")
                let url = URL(fileURLWithPath: path!)
                testOpenSecretsURLs.append(url)
            }
            
            return testOpenSecretsURLs
        } else {
            
            let openSecretsAPIKey = ProcessInfo.processInfo.environment["OpenSecrets_API_Key"]
            
            var openSecretsURLs = [URL]()
            
            let senatorOneURL = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.senatorOne.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json")
            
            let senatorTwoURL = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.senatorTwo.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json")
            
            let repURL = URL (string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.representative.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json")
            
            openSecretsURLs.append(senatorOneURL!)
            openSecretsURLs.append(senatorTwoURL!)
            openSecretsURLs.append(repURL!)

            
            return openSecretsURLs
            
        }
    }
    
    func getReps(googleCivicInfoURL: URL) {
        let url = googleCivicInfoURL
        
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
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            senatorOne.ocdID = "ocd-person/00c39487-8eec-5494-af5e-96e9b025a39b"
            senatorTwo.ocdID = "ocd-person/09a67947-f66a-55ac-b4ba-5c656ad7f67d"
            representative.ocdID = "ocd-person/b4bfc55d-3cdd-5a6e-accf-912a2b2d28b8"
        } else {
            let ocdIDCollection = fuzzySearch(candidates: candidates)
            senatorOne.ocdID = ocdIDCollection[0]
            senatorTwo.ocdID = ocdIDCollection[1]
            representative.ocdID = ocdIDCollection[2]
        }
        
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
    
    
    
    func getTopSixContributorInfo(openSecretsURLs: [URL]) {
        
        for currentURL in openSecretsURLs {
            URLSession.shared.dataTask(with: currentURL) { (data, _, _) in
                guard let data = data else {return}
                do {
                    let contributors = try? JSONDecoder().decode(Contributors.self, from: data)
                    if self.senatorOne.contributors == nil {
                        self.senatorOne.contributors = contributors!.response.contributors.contributor
                    } else if self.senatorTwo.contributors == nil {
                        self.senatorTwo.contributors = contributors!.response.contributors.contributor
                    } else if self.representative.contributors == nil {
                        self.representative.contributors = contributors!.response.contributors.contributor
                    }
                } catch {
                    print("Unexpected error: \(error).")
                }
            }
            .resume()
            
        }
    }
    
    func getMaxSenateCommitteePages(completion: @escaping (Int) -> Void) {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            return completion(2)
        }
        
        
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
                
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            let bundle = Bundle(for: MyRepsViewModel.self)
            let path = bundle.path(forResource: "successful-open-states-upper-house-committee-request-page-\(currentPage)", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else {return}
                do {
                    let senateCommitteeList = try JSONDecoder().decode(CommitteeList.self, from: data)
                    completion(senateCommitteeList)
                    
                } catch {
                    print("Unexpected error: \(error).")
                }
            }.resume()
            
        } else {
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
        }
    }
    
    func getMaxHouseCommitteePages(completion: @escaping (Int) -> Void) {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            return completion(2)
        }
        
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
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            let bundle = Bundle(for: MyRepsViewModel.self)
            let path = bundle.path(forResource: "successful-open-states-lower-house-committee-request-page-\(currentPage)", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else {return}
                do {
                    let houseCommitteeList = try JSONDecoder().decode(CommitteeList.self, from: data)
                    completion(houseCommitteeList)
                    
                } catch {
                    print("Unexpected error: \(error).")
                }
            }.resume()
            
        } else {
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
        }
    }
}
