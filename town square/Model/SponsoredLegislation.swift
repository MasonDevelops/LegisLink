//
//  SponsoredLegislation.swift
//  town square
//
//  Created by Mason Cochran on 10/26/23.
//

import Foundation

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
