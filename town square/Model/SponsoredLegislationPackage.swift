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
    let request: CongressGovRequest
    let sponsoredLegislation: [SponsoredLegislation]
}

// MARK: - SponsoredLegislationPackagePagination
struct SponsoredLegislationPackagePagination: Codable {
    let count: Int
    let next: String?
}

// MARK: - Request -> CongressGovRequest

// MARK: - SponsoredLegislation -> SponsoredLegislation


// MARK: - LatestAction
struct LatestAction: Codable {
    let actionDate, text: String
}

// MARK: - PolicyArea
struct PolicyArea: Codable {
    let name: String?
}
