//
//  FindYourRepTests.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 8/2/23.
//

import XCTest

@testable import town_square

final class FindYourRepTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulGoogleCivicInformationAPIRequest() throws {
        
        let testUser = User(id: "test_user_0", email: "test_email@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
    
        let testRepsVM = MyRepsViewModel(user: testUser)
        
        XCTAssertEqual(testRepsVM.senatorOne.name, "Jerry Moran")
        XCTAssertEqual(testRepsVM.senatorTwo.name, "Roger Marshall")
        XCTAssertEqual(testRepsVM.representative.name, "Jake LaTurner")
        
    }
    
    func testSuccessfulOpenSecretsAPIRequest() throws {
        
        let testUser = User(id: "test_user_0", email: "test_email@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
    
        let testRepsVM = MyRepsViewModel(user: testUser)
        
        XCTAssertEqual(testRepsVM.senatorOne.contributors![0].attributes.orgName, "Live Nation Entertainment")
        XCTAssertEqual(testRepsVM.senatorOne.contributors![1].attributes.orgName, "Spirit Aerosystems")
        XCTAssertEqual(testRepsVM.senatorOne.contributors![2].attributes.orgName, "Hilltop Holdings")
        XCTAssertEqual(testRepsVM.senatorTwo.contributors![0].attributes.orgName, "Nueterra Capital")
        XCTAssertEqual(testRepsVM.senatorTwo.contributors![1].attributes.orgName, "Poet LLC")
        XCTAssertEqual(testRepsVM.senatorTwo.contributors![2].attributes.orgName, "Burns & McDonnell")
        XCTAssertEqual(testRepsVM.representative.contributors![0].attributes.orgName, "Onyx Collection")
        XCTAssertEqual(testRepsVM.representative.contributors![1].attributes.orgName, "Crossland Construction")
        XCTAssertEqual(testRepsVM.representative.contributors![2].attributes.orgName, "Watco Companies")
 
        
    }
    
    func testSuccessfulOpenStatesAPIRequest() throws {
        
        let testUser = User(id: "test_user_0", email: "test_email@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
    
        let testRepsVM = MyRepsViewModel(user: testUser)
        
        XCTAssertEqual(testRepsVM.senatorOne.committees![0], "Senate Committee on Appropriations")
        XCTAssertEqual(testRepsVM.senatorOne.committees![1], "Senate Committee on Commerce, Science, and Transportation")
        XCTAssertEqual(testRepsVM.senatorOne.committees![2], "Senate Committee on Veterans' Affairs")
        XCTAssertEqual(testRepsVM.senatorOne.committees![3], "Senate Select Committee on Intelligence")
        
        XCTAssertEqual(testRepsVM.senatorTwo.committees![0], "Senate Committee on Agriculture, Nutrition, and Forestry")
        XCTAssertEqual(testRepsVM.senatorTwo.committees![1], "Senate Committee on Health, Education, Labor, and Pensions")
        XCTAssertEqual(testRepsVM.senatorTwo.committees![2], "Senate Committee on Homeland Security and Governmental Affairs")
        XCTAssertEqual(testRepsVM.senatorTwo.committees![3], "Senate Committee on the Budget")
        
        XCTAssertEqual(testRepsVM.representative.committees![0], "House Committee on Appropriations")
        XCTAssertEqual(testRepsVM.representative.committees![1], "House Committee on Oversight and Reform")

 
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
