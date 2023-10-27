//
//  SponsoredLegislationPackage.swift
//  town square
//
//  Created by Mason Cochran on 8/17/23.
//


import Foundation

// MARK: - SponsoredLegislationPackage
struct SponsoredLegislationPackage: Codable {
    let pagination: SponsoredLegislationPackagePagination
    let request: Request
    let sponsoredLegislation: [SponsoredLegislation]
}

// MARK: - SponsoredLegislationPackagePagination
struct SponsoredLegislationPackagePagination: Codable {
    let count: Int
    let next: String?
}

// MARK: - Request
struct Request: Codable {
    let bioguideID, contentType, format: String

    enum CodingKeys: String, CodingKey {
        case bioguideID = "bioguideId"
        case contentType, format
    }
}

// MARK: - SponsoredLegislation
struct SponsoredLegislation: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
    
    static func == (lhs: SponsoredLegislation, rhs: SponsoredLegislation) -> Bool {
        return lhs.title == rhs.title && lhs.title == rhs.title

    }
    
    
    let congress: Int
    let introducedDate: String
    let latestAction: LatestAction?
    let number: String?
    let policyArea: PolicyArea?
    let title: String?
    let type: String?
    let url: String
    let amendmentNumber: String?
}

// MARK: - LatestAction
struct LatestAction: Codable {
    let actionDate, text: String
}

// MARK: - PolicyArea
struct PolicyArea: Codable {
    let name: String?
}
