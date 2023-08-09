//
//  FindYourRepTests.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 8/2/23.
//

import XCTest

@testable import town_square

final class FindYourRepTests: XCTestCase {
    
    var mockGoogleService: MockGoogleCivicInfoService!
    var mockOpenStatesService: MockOpenStatesService!
    var mockOpenSecretsService: MockOpenSecretsService!
    
    var testUser: User!
    
    var sutRepsVM: MyRepsViewModel?

    override func setUpWithError() throws {
        
        mockGoogleService = MockGoogleCivicInfoService()
        mockOpenStatesService = MockOpenStatesService()
        mockOpenSecretsService = MockOpenSecretsService()

        
        testUser = User(id: "test_user_0", email: "test_user123@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
    
        sutRepsVM = MyRepsViewModel(user: testUser, googleCivicInfoService: mockGoogleService, openSecretsService: mockOpenSecretsService, openStatesService: mockOpenStatesService)
    }

    override func tearDownWithError() throws {
        mockGoogleService = nil
        mockOpenStatesService = nil
        mockOpenSecretsService = nil
        testUser = nil
        sutRepsVM = nil
    }

    func testSuccessfulGoogleCivicInformationAPIRequest() throws {
        
        XCTAssertEqual(sutRepsVM!.senatorOne.name, "Jerry Moran")
        XCTAssertEqual(sutRepsVM!.senatorTwo.name, "Roger Marshall")
        XCTAssertEqual(sutRepsVM!.representative.name, "Jake LaTurner")
        
    }
    
    func testSuccessfulOpenSecretsAPIRequest() throws {
        
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![0].attributes.orgName, "Live Nation Entertainment")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![1].attributes.orgName, "Spirit Aerosystems")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![2].attributes.orgName, "Hilltop Holdings")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![0].attributes.orgName, "Nueterra Capital")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![1].attributes.orgName, "Poet LLC")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![2].attributes.orgName, "Burns & McDonnell")
        XCTAssertEqual(sutRepsVM!.representative.contributors![0].attributes.orgName, "Onyx Collection")
        XCTAssertEqual(sutRepsVM!.representative.contributors![1].attributes.orgName, "Crossland Construction")
        XCTAssertEqual(sutRepsVM!.representative.contributors![2].attributes.orgName, "Watco Companies")
 
        
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
