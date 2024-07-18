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
    
    var mockUser: User!
    
    var sutRepsVM: MyRepsViewModel?

    override func setUpWithError() throws {
        
        mockGoogleService = MockGoogleCivicInfoService()
        

        
        mockUser = User(id: "test_user_0", email: "test_user123@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
    
        sutRepsVM = MyRepsViewModel(user: mockUser, googleCivicInfoService: mockGoogleService!)
    }

    override func tearDownWithError() throws {
        mockGoogleService = nil
        mockUser = nil
        sutRepsVM = nil
    }

    func testSuccessfulGoogleCivicInformationAPIRequest() throws {
        
        XCTAssertEqual(sutRepsVM!.senatorOne.name, "Jerry Moran")
        XCTAssertEqual(sutRepsVM!.senatorTwo.name, "Roger Marshall")
        XCTAssertEqual(sutRepsVM!.representative.name, "Jake LaTurner")
        
    }
}
