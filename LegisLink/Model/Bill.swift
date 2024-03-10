//
//  Bill.swift
//  LegisLink
//
//  Created by Mason Cochran on 1/22/24.
//

import Foundation

struct Bill: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(url)
        }
    
    static func == (lhs: Bill, rhs: Bill) -> Bool {
        return lhs.url == rhs.url && lhs.url == rhs.url
    }
    
    
    
    let congress: Int
    let latestAction: LatestAction
    let number, originChamber, originChamberCode, title: String
    let type, updateDate: String
    let updateDateIncludingText: String
    let url: String
}





