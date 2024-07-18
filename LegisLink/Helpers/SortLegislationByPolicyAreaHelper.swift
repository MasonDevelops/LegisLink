//
//  SortLegislationByPolicyArea.swift
//  LegisLink
//
//  Created by Mason Cochran on 12/9/23.
//

import Foundation


class SortLegislationByPolicyAreaHelper {
    
    private var official: Official
    
    init(official: Official) {
        self.official = official
    }
    
    
    func sortTransportationAndPublicWorksLegislationForAllReps() -> [[SponsoredLegislation]] {
        
       var tempLegislation = [[SponsoredLegislation]]()
                
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Transportation and Public Works"))
        
        return tempLegislation
    }
    
    func sortTaxationLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()
        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Taxation"))
        
        return tempLegislation
    }
    
    
    
    func sortHealthLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()
        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Health"))
        
        return tempLegislation
    }
    
    
    func sortGovtOpsAndPoliticsLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()
        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Government Operations and Politics"))
        
        return tempLegislation
    }
    
    
    
    func sortArmedForcesAndNatlSecurityLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Armed Forces and National Security"))
        
        return tempLegislation
    }
    
    
    func sortCongressLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Congress"))
        
        return tempLegislation
    }
    
    
    func sortInternationalAffairsLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "International Affairs"))
        
        
        return tempLegislation
    }
    
    
    func sortPublicLandsAndNatResourcesLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Public Lands and Natural Resources"))
        
        return tempLegislation
    }
    
    func sortForeignTradeIntlFinanceLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Foreign Trade and International Finance"))
        
        return tempLegislation
    }
    
    func sortCrimeAndLawEnforcementLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Crime and Law Enforcement"))
        
        return tempLegislation
    }
    
    func sortEducationLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Education"))
        
        return tempLegislation
    }
    
    func sortSocialWelfareLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Social Welfare"))
        
        return tempLegislation
    }
    
    func sortEnergyLegislationForAllReps() -> [[SponsoredLegislation]] {
        
        var tempLegislation = [[SponsoredLegislation]]()

        
        tempLegislation.append(filterSponsoredLegislation(official.sponsoredLegislation, policyArea: "Energy"))
        
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
