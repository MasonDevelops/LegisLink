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
    private let openSecretsService: OpenSecretsServiceProtocol
    private let openStatesService: OpenStatesServiceProtocol
    private let congressGovService: CongressGovServiceProtocol
        
    @Published var senatorOne = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
                                         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
                                            type: "type",
                                            id: "id"
                                         )], termsServedInCongress: [Term(chamber: "term", congress: 1, district: 1, endYear: 2050, memberType: "memberType", startYear: 2020, stateCode: "stateCode", stateName: "stateName")])
    
    
    @Published var senatorTwo = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                         
                                         party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
                                            type: "type",
                                            id: "id"
                                         )], termsServedInCongress: [Term(chamber: "term", congress: 1, district: 1, endYear: 2050, memberType: "memberType", startYear: 2020, stateCode: "stateCode", stateName: "stateName")])
    
    @Published var representative = Official(name: "null", address: [NormalizedInput(
        
        line1: "String",
        city: "City",
        state: "State",
        zip: "Zip")],
                                             
                                             party: "party", phones: ["Phone"], urls: ["urls"], photoURL: "photoURL", channels: [Channel(
                                                type: "type",
                                                id: "id"
                                             )], termsServedInCongress: [Term(chamber: "term", congress: 1, district: 1, endYear: 2050, memberType: "memberType", startYear: 2020, stateCode: "stateCode", stateName: "stateName")])
    
    
    init(user: User, googleCivicInfoService: GoogleCivicInfoServiceProtocol,
         openSecretsService: OpenSecretsServiceProtocol,
         openStatesService: OpenStatesServiceProtocol, congressGovService: CongressGovServiceProtocol){
        self.user = user
        self.googleCivicInfoService = googleCivicInfoService
        self.openSecretsService = openSecretsService
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
            getTopContributorInfo(openSecretsURLs: testURLs)
            parseSenateCommitteeLists()
            parseHouseCommitteeLists()
        } else {
            let googleCivicInfoURL = getGoogleCivicInformationAPIURL()
            getRepsFromGoogleCivicAPIService(googleCivicInfoURL: googleCivicInfoURL)
            bundleOpenStatesData()
            let openSecretsAPIURls = getOpenSecretsAPIURLs()
            getTopContributorInfo(openSecretsURLs: openSecretsAPIURls)
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
    
    func getOpenSecretsAPIURLs() -> [URL] {
        
        
        let openSecretsAPIKey = ProcessInfo.processInfo.environment["OpenSecrets_API_Key"]
        
        var openSecretsURLs = [URL]()
        
        let senatorOneURL = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.senatorOne.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json")
        
        let senatorTwoURL = URL(string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.senatorTwo.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json")
        
        let repURL = URL (string: "https://www.opensecrets.org/api/?method=candContrib&cid=\(self.representative.opensecretsID!)&cycle=2022&apikey=\(openSecretsAPIKey!)&output=json")
        
        openSecretsURLs.append(repURL!)
        openSecretsURLs.append(senatorOneURL!)
        openSecretsURLs.append(senatorTwoURL!)
        
        return openSecretsURLs
        
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
        let fm = FileManager.default
        
        let folderPath = Bundle.main.resourcePath?.appending("/US Congress Directory/")
        
        
        var membersOfCongress = [CandidateYAML]()
        
        
        
        do {
            let items = try fm.contentsOfDirectory(atPath: folderPath!)
            
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
    
    
    
    func getTopContributorInfo(openSecretsURLs: [URL]) {
        for currentURL in openSecretsURLs {
            openSecretsService.getTopContributors(from: currentURL) { [weak self] result in
                switch result {
                case .success(let contributors):
                    if self!.senatorOne.opensecretsID == contributors.response.contributors.attributes.cid {
                        self!.senatorOne.contributors = contributors.response.contributors.contributor
                    } else if self!.senatorTwo.opensecretsID == contributors.response.contributors.attributes.cid {
                        self!.senatorTwo.contributors = contributors.response.contributors.contributor
                    } else if self!.representative.opensecretsID == contributors.response.contributors.attributes.cid {
                        self!.representative.contributors = contributors.response.contributors.contributor
                    }
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
            }
        }
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
        congressGovService.getMaxPagination(bioGuideID: self.representative.bioguideID!) { maxPage in
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
        dispatchGroup.wait()
        dispatchGroup.notify(queue: DispatchQueue.main) {}
        
        dispatchGroup.enter()
        congressGovService.getTermsInCongress(bioGuideID: self.senatorTwo.bioguideID!) { senTwoTermInfo in
            self.senatorTwo.termsServedInCongress = senTwoTermInfo
            dispatchGroup.leave()
            
        }
        
        dispatchGroup.wait()
        dispatchGroup.notify(queue: DispatchQueue.main) {}
        
        
        dispatchGroup.enter()
        congressGovService.getTermsInCongress(bioGuideID: self.representative.bioguideID!) { repTermInfo in
            self.representative.termsServedInCongress = repTermInfo
            dispatchGroup.leave()
        }
        
        dispatchGroup.wait()
        dispatchGroup.notify(queue: DispatchQueue.main) {}
        
        
        convertStartAndEndYearsToStrings()
        
        
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
        
        
    }


    
}
    
    
    /*
     Social Welfare[9,971]
     Energy[8,828]
     Agriculture and Food[8,605]
     Labor and Employment[8,214]
     Finance and Financial Sector[8,164]
     Commerce[7,883]
     Environmental Protection[7,798]
     Economics and Public Finance[7,371]
     Immigration[5,629]
     Science, Technology, Communications[5,610]
     Housing and Community Development[4,084]
     Law[3,961]
     Water Resources Development[3,469]
     Native Americans[3,371]
     Civil Rights and Liberties, Minority Issues[3,336]
     Emergency Management[2,950]
     Families[2,014]
     Animals[1,807]
     Arts, Culture, Religion[1,768]
     Sports and Recreation[1,673]
     Social Sciences and History[500]
*/
    
    

