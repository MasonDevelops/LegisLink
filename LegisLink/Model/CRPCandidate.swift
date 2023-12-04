//
//  CRPCandidate.swift
//  town square
//
//  Created by Mason Cochran on 6/7/23.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cRPCandidate = try? JSONDecoder().decode(CRPCandidate.self, from: jsonData)

import Foundation

import Fuse


// MARK: - CRPCandidateElement
struct CRPCandidateElement: Codable, Fuseable {
    let cid: String
    dynamic var crpName: String
    let party: String
    let office: String
    let fecCandID: String
    
    var properties: [FuseProperty] {
            return [
                FuseProperty(name: "crpName", weight: 0.3),
            ]
        }
    
    enum CodingKeys: String, CodingKey {
        case cid = "CID"
        case crpName = "CRPName"
        case office = "Office"
        case party = "Party"
        case fecCandID = "FECCandID"
    }
}
