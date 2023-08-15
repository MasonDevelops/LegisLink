//
//  Contributors.swift
//  town square
//
//  Created by Mason Cochran on 6/9/23.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let contributors = try? JSONDecoder().decode(Contributors.self, from: jsonData)

import Foundation

// MARK: - Contributors
struct Contributors: Codable {
    var response: Response

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

// MARK: - Response
struct Response: Codable {
    var contributors: ContributorsClass

    enum CodingKeys: String, CodingKey {
        case contributors = "contributors"
    }
}

// MARK: - ContributorsClass
struct ContributorsClass: Codable {
    let attributes: ContributorsAttributes
    var contributor: [Contributor]

    enum CodingKeys: String, CodingKey {
        case attributes = "@attributes"
        case contributor = "contributor"
    }
}

// MARK: - ContributorsAttributes
struct ContributorsAttributes: Codable {
    let candName: String
    let cid: String
    let cycle: String
    let origin: String
    let source: String
    let notice: String

    enum CodingKeys: String, CodingKey {
        case candName = "cand_name"
        case cid = "cid"
        case cycle = "cycle"
        case origin = "origin"
        case source = "source"
        case notice = "notice"
    }
}

// MARK: - Contributor
struct Contributor: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(attributes)
        }
    
    static func == (lhs: Contributor, rhs: Contributor) -> Bool {
        return lhs.attributes == rhs.attributes && lhs.attributes == rhs.attributes
    }
    
    var attributes: ContributorAttributes

    enum CodingKeys: String, CodingKey {
        case attributes = "@attributes"
    }
}

// MARK: - ContributorAttributes
struct ContributorAttributes: Codable, Equatable, Hashable {
    let orgName: String
    var total: String
    let pacs: String
    let indivs: String

    enum CodingKeys: String, CodingKey {
        case orgName = "org_name"
        case total = "total"
        case pacs = "pacs"
        case indivs = "indivs"
    }
}









