//
//  Reps.swift
//  town square
//
//  Created by Mason Cochran on 5/25/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

// MARK: - Reps
struct Reps: Codable {
    let normalizedInput: NormalizedInput
    let kind: String
    let offices: [Office]
    let officials: [Official]
}


// MARK: - NormalizedInput
struct NormalizedInput: Codable {
    let line1, city, state, zip: String
}

// MARK: - Office
struct Office: Codable {
    let name, divisionID: String
    let levels, roles: [String]
    let officialIndices: [Int]

    enum CodingKeys: String, CodingKey {
        case name
        case divisionID = "divisionId"
        case levels, roles, officialIndices
    }
}

class Official: Codable, Hashable, ObservableObject {
    var name: String
    var address: [NormalizedInput]
    var party: String
    var phones: [String]
    var urls: [String]
    var photoURL: String?
    var channels: [Channel]
    var ocdID: String?
    var bioguideID: String?
    var govtrackID: String?
    var wikidataID: String?
    var votesmartID: String?
    var fecID: String?
    var opensecretsID: String?
    var committees: [String: String]?
    var sponsoredLegislation: [SponsoredLegislation]?
    var termsServedInCongress: [Term]?
    var taxationSponsoredLegislation: [SponsoredLegislation]?
    var healthSponsoredLegislation: [SponsoredLegislation]?
    var govtOpsAndPoliticsLegislation: [SponsoredLegislation]?
    var armedForcesAndNatlSecurityLegislation: [SponsoredLegislation]?
    var congressLegislation: [SponsoredLegislation]?
    var intlAffairsLegislation: [SponsoredLegislation]?
    var publicLandsNatResourcesLegislation: [SponsoredLegislation]?
    var foreignTradeAndIntlFinanceLegislation: [SponsoredLegislation]?
    var crimeAndLawEnforcementLegislation: [SponsoredLegislation]?
    var transportationAndPublicWorksLegislation: [SponsoredLegislation]?
    var educationLegislation: [SponsoredLegislation]?
    var socialWelfareLegislation: [SponsoredLegislation]?
    var energyLegislation: [SponsoredLegislation]?
    var twentyTwelveContributors: [Contributor]?
    var twentyFourTeenContributors: [Contributor]?
    var twentySixTeenContributors: [Contributor]?
    var twentyEightTeenContributors: [Contributor]?
    var twentyTwentyContributors: [Contributor]?
    var twentyTwentyTwoContributors: [Contributor]?

    enum CodingKeys: String, CodingKey {
        case name, address, party, phones, urls
        case photoURL = "photoUrl"
        case channels
        case ocdID
        case bioguideID
        case govtrackID
        case wikidataID
        case votesmartID
        case fecID
        case opensecretsID
        case committees
        case sponsoredLegislation
        case termsServedInCongress
        case taxationSponsoredLegislation
        case healthSponsoredLegislation
        case govtOpsAndPoliticsLegislation
        case armedForcesAndNatlSecurityLegislation
        case congressLegislation
        case intlAffairsLegislation
        case twentyTwelveContributors
        case twentyFourTeenContributors
        case twentySixTeenContributors
        case twentyEightTeenContributors
        case twentyTwentyContributors
        case twentyTwentyTwoContributors
    }

    init(name: String, address: [NormalizedInput], party: String, phones: [String], urls: [String], photoURL: String?, channels: [Channel], ocdID: String?, bioguideID: String?, govtrackID: String?, wikidataID: String?, votesmartID: String?, fecID: String?, opensecretsID: String?, committees: [String: String]?, sponsoredLegislation: [SponsoredLegislation]?, termsServedInCongress: [Term]?, taxationSponsoredLegislation: [SponsoredLegislation]?, healthSponsoredLegislation: [SponsoredLegislation]?, govtOpsAndPoliticsLegislation: [SponsoredLegislation]?, armedForcesAndNatlSecurityLegislation: [SponsoredLegislation]?, congressLegislation: [SponsoredLegislation]?, intlAffairsLegislation: [SponsoredLegislation]?, publicLandsNatResourcesLegislation: [SponsoredLegislation]?, foreignTradeAndIntlFinanceLegislation: [SponsoredLegislation]?, crimeAndLawEnforcementLegislation: [SponsoredLegislation]?, transportationAndPublicWorksLegislation: [SponsoredLegislation]?, educationLegislation: [SponsoredLegislation]?, socialWelfareLegislation: [SponsoredLegislation]?, energyLegislation: [SponsoredLegislation]?, twentyTwelveContributors: [Contributor]?, twentyFourTeenContributors: [Contributor]?, twentySixTeenContributors: [Contributor]?, twentyEightTeenContributors: [Contributor]?, twentyTwentyContributors: [Contributor]?, twentyTwentyTwoContributors: [Contributor]?) {
        self.name = name
        self.address = address
        self.party = party
        self.phones = phones
        self.urls = urls
        self.photoURL = photoURL
        self.channels = channels
        self.ocdID = ocdID
        self.bioguideID = bioguideID
        self.govtrackID = govtrackID
        self.wikidataID = wikidataID
        self.votesmartID = votesmartID
        self.fecID = fecID
        self.opensecretsID = opensecretsID
        self.committees = committees
        self.sponsoredLegislation = sponsoredLegislation
        self.termsServedInCongress = termsServedInCongress
        self.taxationSponsoredLegislation = taxationSponsoredLegislation
        self.healthSponsoredLegislation = healthSponsoredLegislation
        self.govtOpsAndPoliticsLegislation = govtOpsAndPoliticsLegislation
        self.armedForcesAndNatlSecurityLegislation = armedForcesAndNatlSecurityLegislation
        self.congressLegislation = congressLegislation
        self.intlAffairsLegislation = intlAffairsLegislation
        self.publicLandsNatResourcesLegislation = publicLandsNatResourcesLegislation
        self.foreignTradeAndIntlFinanceLegislation = foreignTradeAndIntlFinanceLegislation
        self.crimeAndLawEnforcementLegislation = crimeAndLawEnforcementLegislation
        self.transportationAndPublicWorksLegislation = transportationAndPublicWorksLegislation
        self.educationLegislation = educationLegislation
        self.socialWelfareLegislation = socialWelfareLegislation
        self.energyLegislation = energyLegislation
        self.twentyTwelveContributors = twentyTwelveContributors
        self.twentyFourTeenContributors = twentyFourTeenContributors
        self.twentySixTeenContributors = twentySixTeenContributors
        self.twentyEightTeenContributors = twentyEightTeenContributors
        self.twentyTwentyContributors = twentyTwentyContributors
        self.twentyTwentyTwoContributors = twentyTwentyTwoContributors
    }

}



extension Official {
    static func == (lhs: Official, rhs: Official) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
    
    
    // MARK: - Channel
    struct Channel: Codable {
        let type, id: String
    }
    
    
    // MARK: - FeatureID
    struct FeatureID: Codable {
        let cellID, fprint: String
        
        enum CodingKeys: String, CodingKey {
            case cellID = "cellId"
            case fprint
        }
    }
    
