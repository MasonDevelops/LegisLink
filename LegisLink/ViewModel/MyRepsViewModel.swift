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
    private let openStatesService: OpenStatesServiceProtocol
    private let congressGovService: CongressGovServiceProtocol
        
    @Published var senatorOne = Official(
        name: "Senator One",
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
    
    
    init(user: User, googleCivicInfoService: GoogleCivicInfoServiceProtocol,
         openStatesService: OpenStatesServiceProtocol, congressGovService: CongressGovServiceProtocol){
        self.user = user
        self.googleCivicInfoService = googleCivicInfoService
        self.openStatesService = openStatesService
        self.congressGovService = congressGovService
        
        
       
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            
            
            let testURL = URL(string: "https://www.example.com")
            var testURLs = [URL]()
            testURLs.append(testURL!)
            testURLs.append(testURL!)
            testURLs.append(testURL!)
            getRepsFromGoogleCivicAPIService(googleCivicInfoURL: testURL!)
            bundleOpenStatesData()
            parseSenateCommitteeLists()
            parseHouseCommitteeLists()
            fetchRepresentativeSponsoredLegislation()
            fetchSenatorOneSponsoredLegislation()
            fetchSenatorTwoSponsoredLegislation()
            
            bindSponsoredLegislationByPolicy()
            
            
            
            
            
            attachCongressionalTermsInOffice()
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
            bundleOpenStatesData()
            parseSenateCommitteeLists()
            parseHouseCommitteeLists()
            
            
            
            fetchRepresentativeSponsoredLegislation()
            fetchSenatorOneSponsoredLegislation()
            fetchSenatorTwoSponsoredLegislation()
            
            bindSponsoredLegislationByPolicy()
            
            
            
            
            
            attachCongressionalTermsInOffice()
            
            
            
        }
    }
    
    
    
    
    func getGoogleCivicInformationAPIURL() -> URL {
        let googleCivicInformationAPIKey = ProcessInfo.processInfo.environment["Google_API_Key"]
        let fullAddress = user.returnFullAddress()
        let fullAddressEncoded = fullAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlPath = "https://www.googleapis.com/civicinfo/v2/representatives?key=\(googleCivicInformationAPIKey!)&address=\(fullAddressEncoded!)&includedOffices=true&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody"
        
        let url = URL(string: urlPath)
        
        return url!
    }
    
    func getRepsFromGoogleCivicAPIService(googleCivicInfoURL: URL) {
        googleCivicInfoService.getReps(from: googleCivicInfoURL) { [weak self] result in
            switch result {
            case .success(let lawmakers):
                self!.senatorOne = lawmakers.officials[0]
                
                if (self!.senatorOne.photoURL == nil) {
                    self!.senatorOne.photoURL = "photoURL"
                }
                
                self!.senatorTwo = lawmakers.officials[1]
                
                if (self!.senatorTwo.photoURL == nil) {
                    self!.senatorTwo.photoURL = "photoURL"
                }
                
                self!.representative = lawmakers.officials[2]
                
                if (self!.representative.photoURL == nil) {
                    self!.representative.photoURL = "photoURL"
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
    
    
    
    func parseSenateCommitteeLists() {
        let group = DispatchGroup()
        let maxPageGroup = DispatchGroup()
        var currentPage = 1
        var maxPage = 0
        
        maxPageGroup.enter()
        openStatesService.getMaxCommitteePages(from: "upper") { maxPageCallVal in
            maxPage = maxPageCallVal
            maxPageGroup.leave()
        }
        
        maxPageGroup.wait()
        maxPageGroup.notify(queue: DispatchQueue.main) {
        }
        
        while currentPage <= maxPage {
            group.enter()
            openStatesService.getSenateCommitteeData(from: currentPage) { [weak self] result in
                switch result {
                case .success(let committeeListResults):
                    if self!.senatorOne.committees == nil {
                        self!.senatorOne.committees = [:]
                    }
                    
                    if self!.senatorTwo.committees == nil {
                        self!.senatorTwo.committees = [:]
                    }
                    
                    for committeeListResult in committeeListResults.results {
                        for memberships in committeeListResult.memberships {
                            if (self!.senatorOne.ocdID == memberships.person.id) {
                                self!.senatorOne.committees![committeeListResult.name] = memberships.role.rawValue
                            }
                            if (self!.senatorTwo.ocdID == memberships.person.id) {
                                self!.senatorTwo.committees![committeeListResult.name] = memberships.role.rawValue
                            }
                        }
                    }
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
                
                currentPage = currentPage + 1
                group.leave()
            }
            group.wait()
        }
        group.notify(queue: DispatchQueue.main) {
        }
    }
    
    func parseHouseCommitteeLists() {
        let group = DispatchGroup()
        let maxPageGroup = DispatchGroup()
        var currentPage = 1
        var maxPage = 2
        
        maxPageGroup.enter()
        openStatesService.getMaxCommitteePages(from: "lower") { maxPageCallVal in
            maxPage = maxPageCallVal
            maxPageGroup.leave()
        }
        
        maxPageGroup.wait()
        maxPageGroup.notify(queue: DispatchQueue.main) {
        }
        while currentPage <= maxPage {
            group.enter()
            openStatesService.getHouseCommitteeData(from: currentPage) { [weak self] result in
                switch result {
                case .success(let committeeListResults):
                    
                    if self!.representative.committees == nil {
                        self!.representative.committees = [:]
                    }
                    
                    for committeeListResult in committeeListResults.results {
                        for memberships in committeeListResult.memberships {
                            if (self!.representative.ocdID == memberships.person.id) {
                                self!.representative.committees![committeeListResult.name] = memberships.role.rawValue
                            }
                        }
                    }
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
                currentPage = currentPage + 1
                group.leave()
            }
            group.wait()
        }
        group.notify(queue: DispatchQueue.main) {
        }
    }
    
    func fetchRepresentativeSponsoredLegislation() {
        let repMaxPageGroup = DispatchGroup()
        let repSecondaryGroup = DispatchGroup()
        
        var repMaxPage = 0
        
        repMaxPageGroup.enter()
        congressGovService.getMaxPagination(bioGuideID: self.representative.bioguideID!) { maxPage in // sometimes this line fails...hmm
            repMaxPage = maxPage
            repMaxPageGroup.leave()
        }
        repMaxPageGroup.wait()
        repMaxPageGroup.notify(queue: DispatchQueue.main) {
        }
        
        //if maxPage <= 250, do a singular call to retrieve legislation
        
        if (repMaxPage <= 250) {
            let url = congressGovService.createSponsoredLegislationURL(bioGuideID: self.representative.bioguideID!, pageOffset: 0)
            congressGovService.getSponsoredLegislationPackage(from: url) { result in
                switch result {
                case .success(let sponsoredLegislationPackage):
                    self.representative.sponsoredLegislation = sponsoredLegislationPackage.sponsoredLegislation
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
            }
        } else {
            let numOfRequests = (repMaxPage / 250) + 1
            var currentRequest = 0
            var sponsoredLegislationArray = [SponsoredLegislation]()
            
            while currentRequest < numOfRequests {
                
                repSecondaryGroup.enter()
                
                let url = congressGovService.createSponsoredLegislationURL(bioGuideID: self.representative.bioguideID!, pageOffset: currentRequest)
                
                congressGovService.getSponsoredLegislationPackage(from: url) { result in
                    switch result {
                    case .success(let sponsoredLegislationPackage):
                        sponsoredLegislationArray.append(contentsOf: sponsoredLegislationPackage.sponsoredLegislation)
                    case .failure(let error):
                        print("Unexpected error: \(error).")
                    }
                    currentRequest += 1
                    if(sponsoredLegislationArray.count > repMaxPage) {
                        let sponsoredLegisArraySlice = Array(sponsoredLegislationArray[0...repMaxPage - 1])
                        self.representative.sponsoredLegislation = sponsoredLegisArraySlice
                    }
                    repSecondaryGroup.leave()
                    
                }
                repSecondaryGroup.wait()
                
                
                
            }
            repSecondaryGroup.notify(queue: DispatchQueue.main) {
                
            }
            
        }
        
    }
    func fetchSenatorOneSponsoredLegislation() {
        let senOneMaxPageGroup = DispatchGroup()
        let senOneSecondaryGroup = DispatchGroup()
        var senOneMaxPage = 0
        
        senOneMaxPageGroup.enter()
        congressGovService.getMaxPagination(bioGuideID: self.senatorOne.bioguideID!) { maxPage in
            senOneMaxPage = maxPage
            senOneMaxPageGroup.leave()
        }
        senOneMaxPageGroup.wait()
        senOneMaxPageGroup.notify(queue: DispatchQueue.main) {
        }
        
        //if maxPage <= 250, do a singular call to retrieve legislation
        
        if (senOneMaxPage <= 250) {
            let url = congressGovService.createSponsoredLegislationURL(bioGuideID: self.representative.bioguideID!, pageOffset: 0)
            congressGovService.getSponsoredLegislationPackage(from: url) { result in
                switch result {
                case .success(let sponsoredLegislationPackage):
                    self.representative.sponsoredLegislation = sponsoredLegislationPackage.sponsoredLegislation
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
            }
        } else {
            let numOfRequests = (senOneMaxPage / 250) + 1
            var currentRequest = 0
            var sponsoredLegislationArray = [SponsoredLegislation]()
            
            while currentRequest < numOfRequests {
                senOneSecondaryGroup.enter()
                
                let url = congressGovService.createSponsoredLegislationURL(bioGuideID: self.senatorOne.bioguideID!, pageOffset: currentRequest)
                
                
                congressGovService.getSponsoredLegislationPackage(from: url) { result in
                    switch result {
                    case .success(let sponsoredLegislationPackage):
                        sponsoredLegislationArray += sponsoredLegislationPackage.sponsoredLegislation
                        
                    case .failure(let error):
                        print("Unexpected error: \(error).")
                    }
                    currentRequest = currentRequest + 1
                    if (sponsoredLegislationArray.count > senOneMaxPage) {
                        let sponsoredLegisArraySlice = Array(sponsoredLegislationArray[0...senOneMaxPage - 1])
                        self.senatorOne.sponsoredLegislation = sponsoredLegisArraySlice
                    }
                    senOneSecondaryGroup.leave()
                }
                senOneSecondaryGroup.wait()
                
            }
            senOneSecondaryGroup.notify(queue: DispatchQueue.main) {
            }
        }
    }
    
    func fetchSenatorTwoSponsoredLegislation() {
        let senTwoMaxPageGroup = DispatchGroup()
        let senTwoSecondaryGroup = DispatchGroup()
        var senTwoMaxPage = 0
        
        senTwoMaxPageGroup.enter()
        congressGovService.getMaxPagination(bioGuideID: self.senatorOne.bioguideID!) { maxPage in
            senTwoMaxPage = maxPage
            senTwoMaxPageGroup.leave()
        }
        senTwoMaxPageGroup.wait()
        senTwoMaxPageGroup.notify(queue: DispatchQueue.main) {
        }
        
        //if maxPage <= 250, do a singular call to retrieve legislation
        
        if (senTwoMaxPage <= 250) {
            let url = congressGovService.createSponsoredLegislationURL(bioGuideID: self.senatorTwo.bioguideID!, pageOffset: 0)
            congressGovService.getSponsoredLegislationPackage(from: url) { result in
                switch result {
                case .success(let sponsoredLegislationPackage):
                    self.senatorTwo.sponsoredLegislation = sponsoredLegislationPackage.sponsoredLegislation
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
            }
        } else {
            let numOfRequests = (senTwoMaxPage / 250) + 1
            var currentRequest = 0
            var sponsoredLegislationArray = [SponsoredLegislation]()
            
            while currentRequest < numOfRequests {
                senTwoSecondaryGroup.enter()
                
                let url = congressGovService.createSponsoredLegislationURL(bioGuideID: self.senatorTwo.bioguideID!, pageOffset: currentRequest)
                
                
                congressGovService.getSponsoredLegislationPackage(from: url) { result in
                    switch result {
                    case .success(let sponsoredLegislationPackage):
                        sponsoredLegislationArray += sponsoredLegislationPackage.sponsoredLegislation
                        
                    case .failure(let error):
                        print("Unexpected error: \(error).")
                    }
                    currentRequest = currentRequest + 1
                    if (sponsoredLegislationArray.count > senTwoMaxPage) {
                        let sponsoredLegisArraySlice = Array(sponsoredLegislationArray[0...senTwoMaxPage - 1])
                        self.senatorTwo.sponsoredLegislation = sponsoredLegisArraySlice
                    }
                    senTwoSecondaryGroup.leave()
                }
                senTwoSecondaryGroup.wait()
                
            }
            senTwoSecondaryGroup.notify(queue: DispatchQueue.main) {
            }
        }
    }
    
    func attachCongressionalTermsInOffice() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        congressGovService.getTermsInCongress(bioGuideID: self.senatorOne.bioguideID!) { senOneTermInfo in
            self.senatorOne.termsServedInCongress = senOneTermInfo
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.enter()
        congressGovService.getTermsInCongress(bioGuideID: self.senatorTwo.bioguideID!) { senTwoTermInfo in
            self.senatorTwo.termsServedInCongress = senTwoTermInfo
            dispatchGroup.leave()
            
        }
        
        
        
        dispatchGroup.enter()
        congressGovService.getTermsInCongress(bioGuideID: self.representative.bioguideID!) { repTermInfo in
            self.representative.termsServedInCongress = repTermInfo
            dispatchGroup.leave()
        }
        
        dispatchGroup.wait()
        self.convertStartAndEndYearsToStrings()
        
    }
    
    func convertStartAndEndYearsToStrings() {
        for term in 0..<self.senatorOne.termsServedInCongress!.count {
            
            if (self.senatorOne.termsServedInCongress![term].endYear == nil) {
                self.senatorOne.termsServedInCongress![term].endYearString = "Current Year"
            } else {
                self.senatorOne.termsServedInCongress![term].endYearString = String(self.senatorOne.termsServedInCongress![term].endYear ?? 0)
            }
            self.senatorOne.termsServedInCongress![term].startYearString = String(self.senatorOne.termsServedInCongress![term].startYear)
        }
        
        
        for senatorTwoTerm in 0..<self.senatorTwo.termsServedInCongress!.count {
            
            if (self.senatorTwo.termsServedInCongress![senatorTwoTerm].endYear == nil) {
                self.senatorTwo.termsServedInCongress![senatorTwoTerm].endYearString = "Current Year"
            } else {
                self.senatorTwo.termsServedInCongress![senatorTwoTerm].endYearString = String(self.senatorTwo.termsServedInCongress![senatorTwoTerm].endYear ?? 0)
            }
            self.senatorTwo.termsServedInCongress![senatorTwoTerm].startYearString = String(self.senatorTwo.termsServedInCongress![senatorTwoTerm].startYear)
        }
        
        
        for repTerm in 0..<self.representative.termsServedInCongress!.count {
            
            if (self.representative.termsServedInCongress![repTerm].endYear == nil) {
                self.representative.termsServedInCongress![repTerm].endYearString = "Current Year"
            } else {
                self.representative.termsServedInCongress![repTerm].endYearString = String(self.representative.termsServedInCongress![repTerm].endYear ?? 0)
            }
            self.representative.termsServedInCongress![repTerm].startYearString = String(self.representative.termsServedInCongress![repTerm].startYear)
        }
    }
    
    func bindSponsoredLegislationByPolicy() {
        
        let sortLegislationByPolicyAreaHelper = SortLegislationByPolicyAreaHelper(senatorOne: self.senatorOne, senatorTwo: self.senatorTwo, representative: self.representative)
        
        let tempPublicWorksLegis = sortLegislationByPolicyAreaHelper.sortTransportationAndPublicWorksLegislationForAllReps()
        self.senatorOne.transportationAndPublicWorksLegislation = tempPublicWorksLegis[0]
        self.senatorTwo.transportationAndPublicWorksLegislation = tempPublicWorksLegis[1]
        self.representative.transportationAndPublicWorksLegislation = tempPublicWorksLegis[2]
        
        let tempTaxationLegis = sortLegislationByPolicyAreaHelper.sortTaxationLegislationForAllReps()
        self.senatorOne.taxationSponsoredLegislation = tempTaxationLegis[0]
        self.senatorTwo.taxationSponsoredLegislation = tempTaxationLegis[1]
        self.representative.taxationSponsoredLegislation = tempTaxationLegis[2]
        
        let tempHealthLegis = sortLegislationByPolicyAreaHelper.sortHealthLegislationForAllReps()
        self.senatorOne.healthSponsoredLegislation = tempHealthLegis[0]
        self.senatorTwo.healthSponsoredLegislation = tempHealthLegis[1]
        self.representative.healthSponsoredLegislation = tempHealthLegis[2]
        
        let tempGovtOpsLegis = sortLegislationByPolicyAreaHelper.sortGovtOpsAndPoliticsLegislationForAllReps()
        self.senatorOne.govtOpsAndPoliticsLegislation = tempGovtOpsLegis[0]
        self.senatorTwo.govtOpsAndPoliticsLegislation = tempGovtOpsLegis[1]
        self.representative.govtOpsAndPoliticsLegislation = tempGovtOpsLegis[2]
        
        let tempArmedForcesLegis = sortLegislationByPolicyAreaHelper.sortArmedForcesAndNatlSecurityLegislationForAllReps()
        self.senatorOne.armedForcesAndNatlSecurityLegislation = tempArmedForcesLegis[0]
        self.senatorTwo.armedForcesAndNatlSecurityLegislation = tempArmedForcesLegis[1]
        self.representative.armedForcesAndNatlSecurityLegislation = tempArmedForcesLegis[2]
        
        let tempCongressLegis = sortLegislationByPolicyAreaHelper.sortCongressLegislationForAllReps()
        self.senatorOne.congressLegislation = tempCongressLegis[0]
        self.senatorTwo.congressLegislation = tempCongressLegis[1]
        self.representative.congressLegislation = tempCongressLegis[2]
        
        let tempInternationalAffairsLegis = sortLegislationByPolicyAreaHelper.sortInternationalAffairsLegislationForAllReps()
        self.senatorOne.intlAffairsLegislation = tempInternationalAffairsLegis[0]
        self.senatorTwo.intlAffairsLegislation = tempInternationalAffairsLegis[1]
        self.representative.intlAffairsLegislation = tempInternationalAffairsLegis[2]
        
        let tempPublicLandsLegis = sortLegislationByPolicyAreaHelper.sortPublicLandsAndNatResourcesLegislationForAllReps()
        self.senatorOne.publicLandsNatResourcesLegislation = tempPublicLandsLegis[0]
        self.senatorTwo.publicLandsNatResourcesLegislation = tempPublicLandsLegis[1]
        self.representative.publicLandsNatResourcesLegislation = tempPublicLandsLegis[2]
        
        let tempForeignTradeLegis = sortLegislationByPolicyAreaHelper.sortForeignTradeIntlFinanceLegislationForAllReps()
        self.senatorOne.foreignTradeAndIntlFinanceLegislation = tempForeignTradeLegis[0]
        self.senatorTwo.foreignTradeAndIntlFinanceLegislation = tempForeignTradeLegis[1]
        self.representative.foreignTradeAndIntlFinanceLegislation = tempForeignTradeLegis[2]
        
        let tempCrimeLegis = sortLegislationByPolicyAreaHelper.sortCrimeAndLawEnforcementLegislationForAllReps()
        self.senatorOne.crimeAndLawEnforcementLegislation = tempCrimeLegis[0]
        self.senatorTwo.crimeAndLawEnforcementLegislation = tempCrimeLegis[1]
        self.representative.crimeAndLawEnforcementLegislation = tempCrimeLegis[2]
        
        let tempEducationLegis = sortLegislationByPolicyAreaHelper.sortEducationLegislationForAllReps()
        self.senatorOne.educationLegislation = tempEducationLegis[0]
        self.senatorTwo.educationLegislation = tempEducationLegis[1]
        self.representative.educationLegislation = tempEducationLegis[2]
        
        let tempSocialWelfareLegis = sortLegislationByPolicyAreaHelper.sortSocialWelfareLegislationForAllReps()
        self.senatorOne.socialWelfareLegislation = tempSocialWelfareLegis[0]
        self.senatorTwo.socialWelfareLegislation = tempSocialWelfareLegis[1]
        self.representative.socialWelfareLegislation = tempSocialWelfareLegis[2]
        
        let tempEnergyLegis = sortLegislationByPolicyAreaHelper.sortEnergyLegislationForAllReps()
        self.senatorOne.energyLegislation = tempEnergyLegis[0]
        self.senatorTwo.energyLegislation = tempEnergyLegis[1]
        self.representative.energyLegislation = tempEnergyLegis[2]
        
        
    }
    
    func getS3Data() async throws {
        let handler = try await DownloadUSCongressDirectoryHandler()
    }
    
}
    
    

    
    

