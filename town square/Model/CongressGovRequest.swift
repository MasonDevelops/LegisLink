//
//  CongressGovRequest.swift
//  town square
//
//  Created by Mason Cochran on 10/26/23.
//

import Foundation


struct CongressGovRequest: Codable {
    let bioguideID, contentType, format: String

    enum CodingKeys: String, CodingKey {
        case bioguideID = "bioguideId"
        case contentType, format
    }
}
