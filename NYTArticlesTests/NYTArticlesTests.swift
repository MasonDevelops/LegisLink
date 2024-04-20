//
//  NYTArticlesTests.swift
//  NYTArticlesTests
//
//  Created by Mason Cochran on 4/14/24.
//

import XCTest

import Foundation

@testable import LegisLink


final class NYTArticlesTests: XCTestCase {
    
    var mockNewYorkTimesService: MockNewYorkTimesService!
    
    var sutNYTFeedViewModel: NYTFeedViewModel!
    
    override func setUpWithError() throws {
        mockNewYorkTimesService = MockNewYorkTimesService()
        
        sutNYTFeedViewModel = NYTFeedViewModel(nytService: mockNewYorkTimesService)
    }
    
    
    override func tearDownWithError() throws {
        mockNewYorkTimesService = nil
        sutNYTFeedViewModel = nil
    }
    
    func testArticleOneComponents() {
        
        let articles = sutNYTFeedViewModel.articles
        
        XCTAssertEqual("Harvard’s President Resigned After Plagiarism Accusations", articles[0].headline.main)
        XCTAssertEqual("By Matthew Cullen", articles[0].byline.original)
        XCTAssertEqual("Also, a senior Hamas leader was killed in Beirut. Here’s the latest at the end of Tuesday.", articles[0].snippet)
        XCTAssertEqual("images/2024/01/02/multimedia/02evening-nl-harvard/02evening-nl-harvard-articleLarge.jpg", articles[0].multimedia[0].url)
        XCTAssertEqual("Claudine Gay, the president of Harvard, announced today that she will resign after weeks of criticism over her response to antisemitism on campus and questions about her academic record. Her resignation ended a turbulent tenure that began in July.", articles[0].leadParagraph)
        XCTAssertEqual("https://www.nytimes.com/2024/01/02/briefing/harvards-president-resigned-after-plagiarism-accusations.html", articles[0].webURL)
        XCTAssertEqual("The New York Times", articles[0].source.rawValue)
        
        
    }
    
    
    
}

