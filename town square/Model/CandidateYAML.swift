// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

import Foundation

// MARK: - CandidateYAML
struct CandidateYAML: Codable {
    let id, name, givenName, familyName: String
    let gender, birthDate: String
    let image: String
    let party: [Party]
    let roles: [Role]
    let YAMLOffices: [YAMLOffice]?
    let links: [Link]?
    let ids: IDS?
    let otherIdentifiers: [OtherIdentifier]
    let sources: [Source]
    
    enum CodingKeys: String, CodingKey {
        case givenName = "given_name"
        case id
        case familyName = "family_name"
        case name
        case gender
        case birthDate = "birth_date"
        case image
        case party
        case roles
        case YAMLOffices = "offices"
        case links
        case ids
        case otherIdentifiers = "other_identifiers"
        case sources
    }
}

// MARK: - IDS
struct IDS: Codable {
    let twitter: String?
    
    enum CodingKeys: String, CodingKey {
        case twitter
    }
}

// MARK: - Link
struct Link: Codable {
    let url: String
    let note: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case note
    }
}

// MARK: - Office
struct YAMLOffice: Codable {
    let classification: String
    let voice: String?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case classification
        case address
        case voice
    }
}

// MARK: - OtherIdentifier
struct OtherIdentifier: Codable {
    let scheme, identifier: String
    
    enum CodingKeys: String, CodingKey {
        case scheme
        case identifier
    }
}

// MARK: - Party
struct Party: Codable {
    let startDate, endDate, name: String
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
        case name
    }
}

// MARK: - Role
struct Role: Codable {
    let startDate, endDate, type, jurisdiction: String
    let district: String
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
        case type
        case jurisdiction
        case district
    }
}

// MARK: - Source
struct Source: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

