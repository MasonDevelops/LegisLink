//
//  DailyBillsTests.swift
//  DailyBillsTests
//
//  Created by Mason Cochran on 2/24/24.
//

import XCTest

@testable import LegisLink


final class DailyBillsTests: XCTestCase {

    var mockCongressGovService: MockCongressGovService!
    
    var testUser: User!
    
    var sutLegisFeedVM: LegisFeedViewModel?
        
        
        
    override func setUpWithError() throws {
        mockCongressGovService = MockCongressGovService()

        
        testUser = User(id: "test_user_0", email: "test_user123@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
    
        sutLegisFeedVM = LegisFeedViewModel(user: testUser, congressGovService: mockCongressGovService)
    }

    override func tearDownWithError() throws {
        mockCongressGovService = nil
        testUser = nil
        sutLegisFeedVM = nil
    }

    func testLegisFeedVMCurrentDate() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.MM.yyyy"

        let testCompareDate = dateFormatter.string(from: Date())
        
        XCTAssertEqual(testCompareDate, sutLegisFeedVM?.todaysDate)
    }
    
    func testValidDailyBills() throws {
        XCTAssertNotNil(sutLegisFeedVM?.dailyBills)
        XCTAssertEqual(sutLegisFeedVM?.dailyBills[0].title, "Asylum Claims Improvement Act of 2023")
    }
}
