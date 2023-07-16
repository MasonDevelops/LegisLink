import Foundation




struct CommitteeList: Codable {
    let results: [Result]
    let pagination: Pagination
}

struct Pagination: Codable {
    let perPage, page, maxPage, totalItems: Int

    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case page
        case maxPage = "max_page"
        case totalItems = "total_items"
    }
}

struct Result: Codable {
    let id, name: String
    let classification: Classification
    let parentID: ParentID
    let extras: Extras
    let memberships: [Membership]

    enum CodingKeys: String, CodingKey {
        case id, name, classification
        case parentID = "parent_id"
        case extras, memberships
    }
}

enum Classification: String, Codable {
    case committee = "committee"
}

struct Extras: Codable {
    let type: TypeEnum
    let phone: String?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case address = "address"
        case type
    }
}


enum TypeEnum: String, Codable {
    case house = "house"
    case senate = "senate"
}

struct Membership: Codable {
    let personName: String
    let role: CommitteeMemberRole
    let person: Person

    enum CodingKeys: String, CodingKey {
        case personName = "person_name"
        case role, person
    }
}

struct Person: Codable {
    let id, name: String
    let party: CommitteeMemberParty
    let currentRole: CurrentRole?

    enum CodingKeys: String, CodingKey {
        case id, name, party
        case currentRole = "current_role"
    }
}

struct CurrentRole: Codable {
    let title: Title
    let orgClassification: OrgClassification
    let district, divisionID: String

    enum CodingKeys: String, CodingKey {
        case title
        case orgClassification = "org_classification"
        case district
        case divisionID = "division_id"
    }
}

enum OrgClassification: String, Codable {
    case upper = "upper"
    case lower = "lower"
}

enum Title: String, Codable {
    case representative = "Representative"
    case senator = "Senator"
}

enum CommitteeMemberParty: String, Codable {
    case democratic = "Democratic"
    case republican = "Republican"
    case independent = "Independent"
}

enum CommitteeMemberRole: String, Codable {
    case chairman = "Chairman"
    case exOfficio = "Ex Officio"
    case member = "Member"
    case rankingMember = "Ranking Member"
    case viceChairman = "Vice Chairman"
    case chair = "Chair"
    case viceChair = "Vice Chair"
}

enum ParentID: String, Codable {
    case ocdOrganization24Af4233D9B5593391B251D29F721037 = "ocd-organization/24af4233-d9b5-5933-91b2-51d29f721037"
    case ocdOrganization072Da2CeDf8152C39Cc8323E208Cdf10 = "ocd-organization/072da2ce-df81-52c3-9cc8-323e208cdf10"
}
