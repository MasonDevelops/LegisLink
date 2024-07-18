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
    
    private let googleCivicInfoService: GoogleCivicInfoServiceProtocol
        
    @Published var senatorOne = Official(
        name: "Senator One",
        chamber: "Senate",
        address: [
            NormalizedInput(
                line1: "123 Main St",
                city: "Cityville",
                state: "CA",
                zip: "12345"
            )
        ],
        party: "Democratic",
        phones: ["555-1234"],
        urls: ["http://example.com"],
        photoURL: "http://example.com/photo.jpg",
        channels: [
            Channel(
                type: "type",
                id: "id"
            )
        ],
        ocdID: "ocdID123",
        bioguideID: "B123",
        govtrackID: "G123",
        wikidataID: "W123",
        votesmartID: "V123",
        fecID: "F123",
        opensecretsID: "O123",
        committees: ["Committee A": "Committee B"],
        sponsoredLegislation: [
            SponsoredLegislation(
                congress: 116,
                introducedDate: "2022-01-01",
                latestAction: LatestAction(actionDate: "2022-02-02", text: "Default Text"),
                number: "123",
                policyArea: PolicyArea(name: "Default Policy Area"),
                title: "Bill A",
                type: "Bill",
                url: "http://example.com/billA",
                amendmentNumber: "A456"
            )
        ],
        termsServedInCongress: [
            Term(chamber: "Senate", congress: 117, district: 1, endYear: 2026, memberType: "Senator", startYear: 2022, stateCode: "CA", stateName: "California")
        ],
        taxationSponsoredLegislation: nil,
        healthSponsoredLegislation: nil,
        govtOpsAndPoliticsLegislation: nil,
        armedForcesAndNatlSecurityLegislation: nil,
        congressLegislation: nil,
        intlAffairsLegislation: nil,
        publicLandsNatResourcesLegislation: nil,
        foreignTradeAndIntlFinanceLegislation: nil,
        crimeAndLawEnforcementLegislation: nil,
        transportationAndPublicWorksLegislation: nil,
        educationLegislation: nil,
        socialWelfareLegislation: nil,
        energyLegislation: nil,
        twentyTwelveContributors: nil,
        twentyFourTeenContributors: nil,
        twentySixTeenContributors: nil,
        twentyEightTeenContributors: nil,
        twentyTwentyContributors: nil,
        twentyTwentyTwoContributors: nil
    )

    
    
    @Published var senatorTwo = Official(
        name: "Senator Two",
        chamber: "Senate",
        address: [
            NormalizedInput(
                line1: "124 Main St",
                city: "Townville",
                state: "CA",
                zip: "12345"
            )
        ],
        party: "Democratic",
        phones: ["555-1234"],
        urls: ["http://example.com"],
        photoURL: "http://example.com/photo.jpg",
        channels: [
            Channel(
                type: "type",
                id: "id"
            )
        ],
        ocdID: "ocdID123",
        bioguideID: "B123",
        govtrackID: "G123",
        wikidataID: "W123",
        votesmartID: "V123",
        fecID: "F123",
        opensecretsID: "O123",
        committees: ["Committee A": "Committee B"],
        sponsoredLegislation: [
            SponsoredLegislation(
                congress: 200,
                introducedDate: "2100-01-01",
                latestAction: LatestAction(actionDate: "2102-02-02", text: "Default Text"),
                number: "123",
                policyArea: PolicyArea(name: "Default Policy Area"),
                title: "Bill A",
                type: "Bill",
                url: "http://example.com/billA",
                amendmentNumber: "A456"
            )
        ],
        termsServedInCongress: [
            Term(chamber: "Senate", congress: 117, district: 1, endYear: 2026, memberType: "Senator", startYear: 2022, stateCode: "CA", stateName: "California")
        ],
        taxationSponsoredLegislation: nil,
        healthSponsoredLegislation: nil,
        govtOpsAndPoliticsLegislation: nil,
        armedForcesAndNatlSecurityLegislation: nil,
        congressLegislation: nil,
        intlAffairsLegislation: nil,
        publicLandsNatResourcesLegislation: nil,
        foreignTradeAndIntlFinanceLegislation: nil,
        crimeAndLawEnforcementLegislation: nil,
        transportationAndPublicWorksLegislation: nil,
        educationLegislation: nil,
        socialWelfareLegislation: nil,
        energyLegislation: nil,
        twentyTwelveContributors: nil,
        twentyFourTeenContributors: nil,
        twentySixTeenContributors: nil,
        twentyEightTeenContributors: nil,
        twentyTwentyContributors: nil,
        twentyTwentyTwoContributors: nil
    )
    
    @Published var representative = Official(
        name: "Representative",
        chamber: "House of Representatives",
        address: [
            NormalizedInput(
                line1: "125 Main St",
                city: "Cityville",
                state: "CA",
                zip: "12345"
            )
        ],
        party: "Republican",
        phones: ["555-1234"],
        urls: ["http://example.com"],
        photoURL: "http://example.com/photo.jpg",
        channels: [
            Channel(
                type: "type",
                id: "id"
            )
        ],
        ocdID: "ocdID123",
        bioguideID: "B123",
        govtrackID: "G123",
        wikidataID: "W123",
        votesmartID: "V123",
        fecID: "F123",
        opensecretsID: "O123",
        committees: ["Committee A": "Committee B"],
        sponsoredLegislation: [
            SponsoredLegislation(
                congress: 120,
                introducedDate: "2050-01-01",
                latestAction: LatestAction(actionDate: "2050-02-02", text: "Default Text"),
                number: "123",
                policyArea: PolicyArea(name: "Default Policy Area"),
                title: "Bill A",
                type: "Bill",
                url: "http://example.com/billA",
                amendmentNumber: "A456"
            )
        ],
        termsServedInCongress: [
            Term(chamber: "House", congress: 116, district: 1, endYear: 2022, memberType: "Representative", startYear: 2018, stateCode: "CA", stateName: "California"),
        ],
        taxationSponsoredLegislation: nil,
        healthSponsoredLegislation: nil,
        govtOpsAndPoliticsLegislation: nil,
        armedForcesAndNatlSecurityLegislation: nil,
        congressLegislation: nil,
        intlAffairsLegislation: nil,
        publicLandsNatResourcesLegislation: nil,
        foreignTradeAndIntlFinanceLegislation: nil,
        crimeAndLawEnforcementLegislation: nil,
        transportationAndPublicWorksLegislation: nil,
        educationLegislation: nil,
        socialWelfareLegislation: nil,
        energyLegislation: nil,
        twentyTwelveContributors: nil,
        twentyFourTeenContributors: nil,
        twentySixTeenContributors: nil,
        twentyEightTeenContributors: nil,
        twentyTwentyContributors: nil,
        twentyTwentyTwoContributors: nil
    )
    
    
    init(user: User, googleCivicInfoService: GoogleCivicInfoServiceProtocol){
        self.user = user
        self.googleCivicInfoService = googleCivicInfoService
        
        
       
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            
            let testURL = URL(string: "https://www.example.com")
            var testURLs = [URL]()
            testURLs.append(testURL!)
            testURLs.append(testURL!)
            testURLs.append(testURL!)
            getRepsFromGoogleCivicAPIService(googleCivicInfoURL: testURL!)
            
        } else {
            
            
            let group = DispatchGroup()
            group.enter()
            Task {
                do {
                    try await self.getS3Data()
                } catch {
                    print("Error!!")
                }
                group.leave()
            }
            group.wait()
            
            let googleCivicInfoURL = getGoogleCivicInformationAPIURL()
            getRepsFromGoogleCivicAPIService(googleCivicInfoURL: googleCivicInfoURL)
            
        }
    }
    
    
    
    
    func getGoogleCivicInformationAPIURL() -> URL {
        let googleCivicInformationAPIKey = Environment.googleCivicInformationAPI
        let fullAddress = user.returnFullAddress()
        let fullAddressEncoded = fullAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlPath = "https://www.googleapis.com/civicinfo/v2/representatives?key=\(googleCivicInformationAPIKey)&address=\(fullAddressEncoded!)&includedOffices=true&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody"
        
        let url = URL(string: urlPath)
        
        return url!
    }
    
    func getRepsFromGoogleCivicAPIService(googleCivicInfoURL: URL) {
        googleCivicInfoService.getReps(from: googleCivicInfoURL) { result in
            switch result {
            case .success(let lawmakers):
                self.senatorOne = lawmakers.officials[0]
                self.senatorOne.chamber = "Senate"
                
                if (self.senatorOne.photoURL == nil) {
                    self.senatorOne.photoURL = "photoURL"
                }
                
                self.senatorTwo = lawmakers.officials[1]
                self.senatorTwo.chamber = "Senate"
                
                if (self.senatorTwo.photoURL == nil) {
                    self.senatorTwo.photoURL = "photoURL"
                }
                
                self.representative = lawmakers.officials[2]
                self.representative.chamber = "House of Representatives"
                
                if (self.representative.photoURL == nil) {
                    self.representative.photoURL = "photoURL"
                }
            case .failure(let error):
                print("Unexpected error: \(error).")
            }
        }
    }
    
    
    func fetchOpenStatesOfficialData() -> [CandidateYAML] {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
                   
           let folderPath = Bundle.main.resourcePath?.appending("/US Congress Directory/")
           
           
           var membersOfCongress = [CandidateYAML]()
           
           
           
           do {
               let items = try FileManager.default.contentsOfDirectory(atPath: folderPath!)
               
               for item in items {
                   let filePath = folderPath! + item
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
        
        let fileManager = FileManager.default
        
        
        var membersOfCongress = [CandidateYAML]()
        
        let documentsDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        do {
            let items = try fileManager.contentsOfDirectory(atPath: documentsDirectory.path)
            
            for item in items {
                if (item != ".DS_Store") {
                    let filePath = documentsDirectory.appendingPathComponent(item)
                    let contents = try String(contentsOfFile: filePath.path)
                    let decoder = YAMLDecoder()
                    let decoded = try decoder.decode(CandidateYAML.self, from: contents)
                    membersOfCongress.append(decoded)
                }
            }
        } catch {
            print("Error info: \(error)")
        }
            
        
        
        return membersOfCongress
    }
    
    
    func bundleOfficialIdentifiers() {
        
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
                        self.senatorOne.opensecretsID = other_id.identifier
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
                        self.senatorTwo.opensecretsID = other_id.identifier
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

    func getS3Data() async throws {
        let handler = try await DownloadUSCongressDirectoryHandler()
    }
    
}
    
    

    
    

