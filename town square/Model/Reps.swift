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

// MARK: - Official
struct Official: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
    
    static func == (lhs: Official, rhs: Official) -> Bool {
        return lhs.name == rhs.name && lhs.name == rhs.name

    }
    
    var name: String
    let address: [NormalizedInput]
    let party: String
    let phones: [String]
    let urls: [String]
    var photoURL: String?
    let channels: [Channel]
    var ocdID: String?
    var bioguideID: String?
    var govtrackID: String?
    var wikidataID: String?
    var votesmartID: String?
    var fecID: String?
    var opensecretsID: String?
    var contributors: [Contributor]?
    var committees: [String]?

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
        case contributors
        case committees
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

