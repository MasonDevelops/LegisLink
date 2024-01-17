//
//  FindYourRepTests.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 8/2/23.
//

import XCTest

@testable import LegisLink

final class FindYourRepTests: XCTestCase {
    
    var mockGoogleService: MockGoogleCivicInfoService!
    var mockOpenStatesService: MockOpenStatesService!
    var mockOpenSecretsService: MockOpenSecretsService!
    var mockCongressGovService: MockCongressGovService!
    
    var testUser: User!
    
    var sutRepsVM: MyRepsViewModel?

    override func setUpWithError() throws {
        
        mockGoogleService = MockGoogleCivicInfoService()
        mockOpenStatesService = MockOpenStatesService()
        mockOpenSecretsService = MockOpenSecretsService()
        mockCongressGovService = MockCongressGovService()

        
        testUser = User(id: "test_user_0", email: "test_user123@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
    
        sutRepsVM = MyRepsViewModel(user: testUser, googleCivicInfoService: mockGoogleService, openStatesService: mockOpenStatesService, congressGovService: mockCongressGovService)
    }

    override func tearDownWithError() throws {
        mockGoogleService = nil
        mockOpenStatesService = nil
        mockOpenSecretsService = nil
        mockCongressGovService = nil
        testUser = nil
        sutRepsVM = nil
    }

    func testSuccessfulGoogleCivicInformationAPIRequest() throws {
        
        XCTAssertEqual(sutRepsVM!.senatorOne.name, "Jerry Moran")
        XCTAssertEqual(sutRepsVM!.senatorTwo.name, "Roger Marshall")
        XCTAssertEqual(sutRepsVM!.representative.name, "Jake LaTurner")
        
    }
    
    
    func testSuccessfulOpenStatesAPIRequest() throws {

        XCTAssertEqual(sutRepsVM!.senatorOne.committees!["Senate Committee on Appropriations"], "Member")
        XCTAssertEqual(sutRepsVM!.senatorOne.committees!["Senate Committee on Commerce, Science, and Transportation"], "Member")
        XCTAssertEqual(sutRepsVM!.senatorOne.committees!["Senate Committee on Veterans' Affairs"], "Ranking Member")
        XCTAssertEqual(sutRepsVM!.senatorOne.committees!["Senate Select Committee on Intelligence"], "Member")

        XCTAssertEqual(sutRepsVM!.senatorTwo.committees!["Senate Committee on Agriculture, Nutrition, and Forestry"], "Member")
        XCTAssertEqual(sutRepsVM!.senatorTwo.committees!["Senate Committee on Health, Education, Labor, and Pensions"], "Member")
        XCTAssertEqual(sutRepsVM!.senatorTwo.committees!["Senate Committee on Homeland Security and Governmental Affairs"], "Member")
        XCTAssertEqual(sutRepsVM!.senatorTwo.committees!["Senate Committee on the Budget"], "Member")

        XCTAssertEqual(sutRepsVM!.representative.committees!["House Committee on Appropriations"], "Member")
        XCTAssertEqual(sutRepsVM!.representative.committees!["House Committee on Oversight and Reform"], "Member")
    }
}
