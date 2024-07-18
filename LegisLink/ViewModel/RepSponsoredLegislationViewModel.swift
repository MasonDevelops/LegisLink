//
//  RepSponsoredLegislationViewModel.swift
//  LegisLink
//
//  Created by Mason Cochran on 6/19/24.
//

import Foundation

class RepSponsoredLegislationViewModel: ObservableObject {
    
    
    private var user: User
    private let congressGovService: CongressGovServiceProtocol


    @Published var official: Official

    init(user: User, congressGovService: CongressGovServiceProtocol, official: Official) {
        self.user = user
        self.congressGovService = congressGovService
        self.official = official
        
        fetchSponsoredLegislation()
        bindSponsoredLegislationByPolicy()
        attachCongressionalTermsInOffice()
    }
    
    
    func fetchSponsoredLegislation() {
        let maxPageGroup = DispatchGroup()
        let secondaryGroup = DispatchGroup()
        var maxPageVal = 0
        
        maxPageGroup.enter()
        congressGovService.getMaxPagination(bioGuideID: official.bioguideID!) { maxPage in
            maxPageVal = maxPage
            maxPageGroup.leave()
        }
        maxPageGroup.wait()
        maxPageGroup.notify(queue: DispatchQueue.main) {
        }
        
        //if maxPage <= 250, do a singular call to retrieve legislation
        
        if (maxPageVal <= 250) {
            let url = congressGovService.createSponsoredLegislationURL(bioGuideID: self.official.bioguideID!, pageOffset: 0)
            congressGovService.getSponsoredLegislationPackage(from: url) { result in
                switch result {
                case .success(let sponsoredLegislationPackage):
                    self.official.sponsoredLegislation = sponsoredLegislationPackage.sponsoredLegislation
                case .failure(let error):
                    print("Unexpected error: \(error).")
                }
            }
        } else {
            let numOfRequests = (maxPageVal / 250) + 1
            var currentRequest = 0
            var sponsoredLegislationArray = [SponsoredLegislation]()
            
            while currentRequest < numOfRequests {
                secondaryGroup.enter()
                
                let url = congressGovService.createSponsoredLegislationURL(bioGuideID: official.bioguideID!, pageOffset: currentRequest)
                
                
                congressGovService.getSponsoredLegislationPackage(from: url) { result in
                    switch result {
                    case .success(let sponsoredLegislationPackage):
                        sponsoredLegislationArray += sponsoredLegislationPackage.sponsoredLegislation
                        
                    case .failure(let error):
                        print("Unexpected error: \(error).")
                    }
                    currentRequest = currentRequest + 1
                    if (sponsoredLegislationArray.count > maxPageVal) {
                        let sponsoredLegisArraySlice = Array(sponsoredLegislationArray[0...maxPageVal - 1])
                        self.official.sponsoredLegislation = sponsoredLegisArraySlice
                    }
                    secondaryGroup.leave()
                }
                secondaryGroup.wait()
                
            }
            secondaryGroup.notify(queue: DispatchQueue.main) {
            }
        }
    }
    
    func bindSponsoredLegislationByPolicy() {
        
        let sortLegislationByPolicyAreaHelper = SortLegislationByPolicyAreaHelper(official: self.official)
        
        let tempPublicWorksLegis = sortLegislationByPolicyAreaHelper.sortTransportationAndPublicWorksLegislationForAllReps()
        self.official.transportationAndPublicWorksLegislation = tempPublicWorksLegis[0]
        
        let tempTaxationLegis = sortLegislationByPolicyAreaHelper.sortTaxationLegislationForAllReps()
        self.official.taxationSponsoredLegislation = tempTaxationLegis[0]
        
        let tempHealthLegis = sortLegislationByPolicyAreaHelper.sortHealthLegislationForAllReps()
        self.official.healthSponsoredLegislation = tempHealthLegis[0]
        
        let tempGovtOpsLegis = sortLegislationByPolicyAreaHelper.sortGovtOpsAndPoliticsLegislationForAllReps()
        self.official.govtOpsAndPoliticsLegislation = tempGovtOpsLegis[0]
        
        let tempArmedForcesLegis = sortLegislationByPolicyAreaHelper.sortArmedForcesAndNatlSecurityLegislationForAllReps()
        self.official.armedForcesAndNatlSecurityLegislation = tempArmedForcesLegis[0]
        
        let tempCongressLegis = sortLegislationByPolicyAreaHelper.sortCongressLegislationForAllReps()
        self.official.congressLegislation = tempCongressLegis[0]
        
        let tempInternationalAffairsLegis = sortLegislationByPolicyAreaHelper.sortInternationalAffairsLegislationForAllReps()
        self.official.intlAffairsLegislation = tempInternationalAffairsLegis[0]
        
        let tempPublicLandsLegis = sortLegislationByPolicyAreaHelper.sortPublicLandsAndNatResourcesLegislationForAllReps()
        self.official.publicLandsNatResourcesLegislation = tempPublicLandsLegis[0]
        
        let tempForeignTradeLegis = sortLegislationByPolicyAreaHelper.sortForeignTradeIntlFinanceLegislationForAllReps()
        self.official.foreignTradeAndIntlFinanceLegislation = tempForeignTradeLegis[0]
        
        let tempCrimeLegis = sortLegislationByPolicyAreaHelper.sortCrimeAndLawEnforcementLegislationForAllReps()
        self.official.crimeAndLawEnforcementLegislation = tempCrimeLegis[0]
        
        let tempEducationLegis = sortLegislationByPolicyAreaHelper.sortEducationLegislationForAllReps()
        self.official.educationLegislation = tempEducationLegis[0]

        
        let tempSocialWelfareLegis = sortLegislationByPolicyAreaHelper.sortSocialWelfareLegislationForAllReps()
        self.official.socialWelfareLegislation = tempSocialWelfareLegis[0]
        
        let tempEnergyLegis = sortLegislationByPolicyAreaHelper.sortEnergyLegislationForAllReps()
        self.official.energyLegislation = tempEnergyLegis[0]
        
        
    }
    
    func attachCongressionalTermsInOffice() {
        
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        congressGovService.getTermsInCongress(bioGuideID: self.official.bioguideID!) { officialTermInfo in
            self.official.termsServedInCongress = officialTermInfo
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.wait()
        self.convertStartAndEndYearsToStrings()
        
    }
    
    func convertStartAndEndYearsToStrings() {
        for term in 0..<self.official.termsServedInCongress!.count {
            
            if (self.official.termsServedInCongress![term].endYear == nil) {
                self.official.termsServedInCongress![term].endYearString = "Current Year"
            } else {
                self.official.termsServedInCongress![term].endYearString = String(self.official.termsServedInCongress![term].endYear ?? 0)
            }
            self.official.termsServedInCongress![term].startYearString = String(self.official.termsServedInCongress![term].startYear)
        }

    }
    
    
}






