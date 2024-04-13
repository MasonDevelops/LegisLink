//
//  NYTRequest.swift
//  LegisLink
//
//  Created by Mason Cochran on 3/16/24.
//

import Foundation
//   let nYTRequest = try? JSONDecoder().decode(NYTRequest.self, from: jsonData)


// MARK: - NYTRequest
struct NYTRequest: Codable {
    let status, copyright: String
    let response: NYTResponse
}

// MARK: - Response
struct NYTResponse: Codable {
    let docs: [Doc]
    let meta: Meta
}

// MARK: - Doc
struct Doc: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(webURL)
        }
    
    static func == (lhs: Doc, rhs: Doc) -> Bool {
        return lhs.webURL == rhs.webURL && lhs.webURL == rhs.webURL
    }
    
    
    let abstract: String
    let webURL: String
    let snippet, leadParagraph: String
    let printSection, printPage: String?
    let source: NYTSource
    let multimedia: [Multimedia]
    let headline: Headline
    let keywords: [Keyword]
    let pubDate: String
    let documentType: DocumentType
    let newsDesk, sectionName: String
    let subsectionName: String?
    let byline: Byline
    let typeOfMaterial: String
    let id: String
    let wordCount: Int
    let uri: String

    enum CodingKeys: String, CodingKey {
        case abstract
        case webURL = "web_url"
        case snippet
        case leadParagraph = "lead_paragraph"
        case printSection = "print_section"
        case printPage = "print_page"
        case source, multimedia, headline, keywords
        case pubDate = "pub_date"
        case documentType = "document_type"
        case newsDesk = "news_desk"
        case sectionName = "section_name"
        case subsectionName = "subsection_name"
        case byline
        case typeOfMaterial = "type_of_material"
        case id = "_id"
        case wordCount = "word_count"
        case uri
    }
}

// MARK: - Byline
struct Byline: Codable {
    let original: String?
    let person: [NYTPerson]
    let organization: String?
}

// MARK: - Person
struct NYTPerson: Codable {
    let firstname: String
    let middlename: String?
    let lastname: String?
    let qualifier, title: String?
    let role: NYTRole
    let organization: String
    let rank: Int
}

enum NYTRole: String, Codable {
    case reported = "reported"
}

enum DocumentType: String, Codable {
    case article = "article"
}

// MARK: - Headline
struct Headline: Codable {
    let main: String
    let kicker: String?
    let contentKicker: String??
    let printHeadline: String?
    let name, seo, sub: String??

    enum CodingKeys: String, CodingKey {
        case main, kicker
        case contentKicker = "content_kicker"
        case printHeadline = "print_headline"
        case name, seo, sub
    }
}

// MARK: - Keyword
struct Keyword: Codable {
    let name: Name
    let value: String
    let rank: Int
    let major: Major
}

enum Major: String, Codable {
    case n = "N"
}

enum Name: String, Codable {
    case glocations = "glocations"
    case organizations = "organizations"
    case persons = "persons"
    case subject = "subject"
    case creativeWorks = "creative_works"
}

// MARK: - Multimedia
struct Multimedia: Codable {
    let rank: Int
    let subtype: String
    let caption, credit: String??
    let type: NYTTypeEnum
    let url: String
    let height, width: Int
    let legacy: Legacy
    let subType, cropName: String

    enum CodingKeys: String, CodingKey {
        case rank, subtype, caption, credit, type, url, height, width, legacy, subType
        case cropName = "crop_name"
    }
}

// MARK: - Legacy
struct Legacy: Codable {
    let xlarge: String?
    let xlargewidth, xlargeheight: Int?
    let thumbnail: String?
    let thumbnailwidth, thumbnailheight, widewidth, wideheight: Int?
    let wide: String?
}

enum NYTTypeEnum: String, Codable {
    case image = "image"
}

enum NYTSource: String, Codable {
    case theNewYorkTimes = "The New York Times"
}

// MARK: - Meta
struct Meta: Codable {
    let hits, offset, time: Int
}












