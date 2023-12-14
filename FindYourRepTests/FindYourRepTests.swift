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
    
        sutRepsVM = MyRepsViewModel(user: testUser, googleCivicInfoService: mockGoogleService, openSecretsService: mockOpenSecretsService, openStatesService: mockOpenStatesService, congressGovService: mockCongressGovService)
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
    
    func testSuccessfulOpenSecretsAPIRequestContributorNames() throws {
        
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![0].attributes.orgName, "Votesane PAC")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![1].attributes.orgName, "American Israel Public Affairs Cmte")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![2].attributes.orgName, "DISH Network")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![3].attributes.orgName, "Apollo Global Management")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![4].attributes.orgName, "Kit Bond Strategies")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![5].attributes.orgName, "Cox Enterprises")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![6].attributes.orgName, "NextEra Energy")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![7].attributes.orgName, "Comcast Corp")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![8].attributes.orgName, "NorPAC")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![9].attributes.orgName, "Berkshire Hathaway")

        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![0].attributes.orgName, "AVG Advanced Technologies")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![1].attributes.orgName, "Alsaker Corp")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![2].attributes.orgName, "Moyle Petroleum")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![3].attributes.orgName, "Starkey Hearing Technologies")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![4].attributes.orgName, "Novo Nordisk")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![5].attributes.orgName, "Buc-Ee's")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![6].attributes.orgName, "Safari Club International")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![7].attributes.orgName, "Altria Group")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![8].attributes.orgName, "AT&T Inc")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![9].attributes.orgName, "Georgia Crown Dist Co")
        
        
        XCTAssertEqual(sutRepsVM!.representative.contributors![0].attributes.orgName, "Onyx Collection")
        XCTAssertEqual(sutRepsVM!.representative.contributors![1].attributes.orgName, "Watco Companies")
        XCTAssertEqual(sutRepsVM!.representative.contributors![2].attributes.orgName, "Murfin Inc")
        XCTAssertEqual(sutRepsVM!.representative.contributors![3].attributes.orgName, "Jake'S Fireworks")
        XCTAssertEqual(sutRepsVM!.representative.contributors![4].attributes.orgName, "Poet LLC")
        XCTAssertEqual(sutRepsVM!.representative.contributors![5].attributes.orgName, "American Bankers Assn")
        XCTAssertEqual(sutRepsVM!.representative.contributors![6].attributes.orgName, "Aspire Health Plans")
        XCTAssertEqual(sutRepsVM!.representative.contributors![7].attributes.orgName, "Berexco Inc")
        XCTAssertEqual(sutRepsVM!.representative.contributors![8].attributes.orgName, "Conestoga Energy Partners")
        XCTAssertEqual(sutRepsVM!.representative.contributors![9].attributes.orgName, "Dimensional Fund Advisors")
    }
    
    func testSuccessfulOpenSecretsAPIRequestContributorTotals() throws {
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![0].attributes.total, "$144,400.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![1].attributes.total, "$96,300.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![2].attributes.total, "$43,600.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![3].attributes.total, "$39,700.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![4].attributes.total, "$36,000.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![5].attributes.total, "$31,950.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![6].attributes.total, "$27,000.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![7].attributes.total, "$26,400.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![8].attributes.total, "$24,800.00")
        XCTAssertEqual(sutRepsVM!.senatorOne.contributors![9].attributes.total, "$24,050.00")
        
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![0].attributes.total, "$11,607.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![1].attributes.total, "$11,600.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![2].attributes.total, "$11,600.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![3].attributes.total, "$11,600.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![4].attributes.total, "$10,000.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![5].attributes.total, "$7,900.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![6].attributes.total, "$7,000.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![7].attributes.total, "$6,300.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![8].attributes.total, "$6,000.00")
        XCTAssertEqual(sutRepsVM!.senatorTwo.contributors![9].attributes.total, "$5,800.00")
        
        XCTAssertEqual(sutRepsVM!.representative.contributors![0].attributes.total, "$31,000.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![1].attributes.total, "$17,400.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![2].attributes.total, "$17,203.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![3].attributes.total, "$17,200.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![4].attributes.total, "$16,600.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![5].attributes.total, "$13,000.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![6].attributes.total, "$11,600.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![7].attributes.total, "$11,600.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![8].attributes.total, "$11,600.00")
        XCTAssertEqual(sutRepsVM!.representative.contributors![9].attributes.total, "$11,600.00")
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
