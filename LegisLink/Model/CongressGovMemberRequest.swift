//
//  CongressGovMemberRequest.swift
//  town square
//
//  Created by Mason Cochran on 10/26/23.
//

import Foundation



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let congressGovMemberRequest = try? JSONDecoder().decode(CongressGovMemberRequest.self, from: jsonData)

import Foundation

// MARK: - CongressGovMemberRequest
struct CongressGovMemberRequest: Codable {
    let member: Member
    let request: CongressGovRequest
}

// MARK: - Member
struct Member: Codable {
    let addressInformation: AddressInformation
    let bioguideID, birthYear: String
    let cosponsoredLegislation: SponsoredLegislationInfo
    let currentMember: Bool
    let depiction: Depiction
    let directOrderName: String
    let district: Int?
    let honorificName: String?
    let firstName, invertedOrderName, lastName: String
    let officialWebsiteURL: String
    let partyHistory: [PartyHistory]
    let sponsoredLegislation: SponsoredLegislationInfo
    let state: String
    let terms: [Term]
    let updateDate: String

    enum CodingKeys: String, CodingKey {
        case addressInformation
        case bioguideID = "bioguideId"
        case birthYear, cosponsoredLegislation, currentMember, depiction, directOrderName, district, firstName, honorificName, invertedOrderName, lastName
        case officialWebsiteURL = "officialWebsiteUrl"
        case partyHistory, sponsoredLegislation, state, terms, updateDate
    }
}

// MARK: - AddressInformation
struct AddressInformation: Codable {
    let city, officeAddress, phoneNumber: String
    let district: String?
    let zipCode: Int
    
    enum CodingKeys: String, CodingKey {
        case city, district, officeAddress, phoneNumber, zipCode
    }
}

// MARK: - SponsoredLegislation -> SponsoredLegislationInfo (re-declared here)
struct SponsoredLegislationInfo: Codable {
    let count: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case count, url
    }
}

// MARK: - Depiction
struct Depiction: Codable {
    let attribution: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case attribution
        case imageURL = "imageUrl"
    }
}

// MARK: - PartyHistory
struct PartyHistory: Codable {
    let partyAbbreviation, partyName: String
    let startYear: Int
    
    enum CodingKeys: String, CodingKey {
        case partyAbbreviation, partyName, startYear
    }
}

// MARK: - Term
struct Term: Codable, Hashable {
    let chamber: String
    let congress: Int
    let district: Int?
    let endYear: Int?
    let memberType: String
    let startYear: Int
    var startYearString: String?
    var endYearString: String?
    let stateCode, stateName: String
    
    enum CodingKeys: String, CodingKey {
        case chamber
        case congress
        case district
        case endYear
        case memberType
        case startYear
        case stateCode
        case stateName
        case startYearString
        case endYearString
    }
}

// MARK: - Request -> CongressGovRequest


