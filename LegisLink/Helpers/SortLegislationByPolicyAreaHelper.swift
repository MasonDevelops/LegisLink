//
//  SortLegislationByPolicyArea.swift
//  LegisLink
//
//  Created by Mason Cochran on 12/9/23.
//

import Foundation


class SortLegislationByPolicyAreaHelper {
    
    private var senatorOne: Official
    private var senatorTwo: Official
    private var representative: Official
    
    init(senatorOne: Official, senatorTwo: Official, representative: Official) {
        self.senatorOne = senatorOne
        self.senatorTwo = senatorTwo
        self.representative = representative
    }
    
    
    func sortTransportationAndPublicWorksLegislationForAllReps() -> [[SponsoredLegislation]] {
        
       var tempLegislation = [[SponsoredLegislation]]()
                
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Transportation and Public Works"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Transportation and Public Works"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Transportation and Public Works"))
        
        return tempLegislation
    }
    
    func sortTaxationLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()
        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Taxation"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Taxation"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Taxation"))
        
        return tempLegislation
    }
    
    
    
    func sortHealthLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()
        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Health"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Health"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Health"))
        
        return tempLegislation
    }
    
    
    func sortGovtOpsAndPoliticsLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()
        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Government Operations and Politics"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Government Operations and Politics"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Government Operations and Politics"))
        
        return tempLegislation
    }
    
    
    
    func sortArmedForcesAndNatlSecurityLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Armed Forces and National Security"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Armed Forces and National Security"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Armed Forces and National Security"))
        
        return tempLegislation
    }
    
    
    func sortCongressLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Congress"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Congress"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Congress"))
        
        return tempLegislation
    }
    
    
    func sortInternationalAffairsLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "International Affairs"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "International Affairs"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "International Affairs"))
        
        return tempLegislation
    }
    
    
    func sortPublicLandsAndNatResourcesLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Public Lands and Natural Resources"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Public Lands and Natural Resources"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Public Lands and Natural Resources"))
        
        return tempLegislation
    }
    
    func sortForeignTradeIntlFinanceLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Foreign Trade and International Finance"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Foreign Trade and International Finance"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Foreign Trade and International Finance"))
        
        return tempLegislation
    }
    
    func sortCrimeAndLawEnforcementLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Crime and Law Enforcement"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Crime and Law Enforcement"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Crime and Law Enforcement"))
        
        return tempLegislation
    }
    
    func sortEducationLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Education"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Education"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Education"))
        
        return tempLegislation
    }
    
    func sortSocialWelfareLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(senatorOne.sponsoredLegislation, policyArea: "Social Welfare"))
        tempLegislation.append(filterSponsoredLegislation(senatorTwo.sponsoredLegislation, policyArea: "Social Welfare"))
        tempLegislation.append(filterSponsoredLegislation(representative.sponsoredLegislation, policyArea: "Social Welfare"))
        
        return tempLegislation
    }
    
    
    
    
    private func filterSponsoredLegislation(_ legislation: [SponsoredLegislation]?, policyArea: String) -> [SponsoredLegislation] {
        var uniqueLegislation = Set<SponsoredLegislation>()

        return legislation?
            .filter { $0.policyArea?.name == policyArea }
            .filter { uniqueLegislation.insert($0).inserted }
            ?? []
    }
    
}
