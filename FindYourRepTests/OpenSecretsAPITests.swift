//
//  OpenSecretsAPITests.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 1/5/24.
//

import Foundation



import XCTest

@testable import LegisLink

final class OpenSecretsAPITests: XCTestCase {
    
    var mockOpenSecretsService: MockOpenSecretsService!
    
    var mockUser: User!
    
    var mockOfficial: Official!
    
    var sutRepContributorVM: RepContributorsViewModel?
    
    override func setUpWithError() throws {

        mockOpenSecretsService = MockOpenSecretsService()

        
        mockUser = User(id: "test_user_0", email: "test_user123@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
        
        mockOfficial = Official(name: "Jerry Moran",
                                address: [
                                    NormalizedInput(
                                        line1: "521 Dirksen Senate Office Building",
                                        city: "Washington",
                                        state: "DC",
                                        zip: "20510"
                                    )
                                ],
                                party: "Republican Party",
                                phones: ["(202) 224-6521"],
                                urls: [
                                    "https://www.moran.senate.gov/",
                                    "https://en.wikipedia.org/wiki/Jerry_Moran"
                                ],
                                photoURL: "http://example.com/photo.jpg",
                                channels: [
                                    Channel(
                                        type: "Facebook",
                                        id: "jerrymoran"
                                    ),
                                    Channel(
                                        type: "Twitter",
                                        id: "JerryMoran"
                                    )
                                ],
                                ocdID: "ocd-person/00c39487-8eec-5494-af5e-96e9b025a39b",
                                bioguideID: "M000934",
                                govtrackID: "400284",
                                wikidataID: "Q1365787",
                                votesmartID: "542",
                                fecID: "H6KS01096",
                                opensecretsID: "N00005282",
                                committees:
                                ["Senate Committee on Appropriations": "Member",
                                "Senate Committee on Commerce, Science, and Transportation": "Member",
                                 "Senate Select Committee on Intelligence": "Member",
                                 "Senate Committee on Veterans' Affairs": "Ranking Member"
                                ],
                                sponsoredLegislation: [
                                    SponsoredLegislation(
                                        congress: 118,
                                        introducedDate: "2023-12-06",
                                        latestAction: LatestAction(actionDate: "2023-12-06", text:"Submitted in the Senate, considered, and agreed to without amendment and with a preamble by Unanimous Consent. (consideration: CR S5803; text: CR S5810-5811)"),
                                        number: "487",
                                        policyArea: PolicyArea(name: "Armed Forces and National Security"),
                                        title: "A resolution commemorating the centennial of the American Battle Monuments Commission.",
                                        type: "SRES",
                                        url: "https://api.congress.gov/v3/bill/118/sres/487?format=json",
                                        amendmentNumber: nil
                                    )
                                ],
                                termsServedInCongress: [
                                    Term(chamber: "House", congress: 116, district: 1, endYear: 2022, memberType: "Representative", startYear: 2018, stateCode: "CA", stateName: "California"),
                                ],
                                taxationSponsoredLegislation: nil,
                                healthSponsoredLegislation: nil,
                                govtOpsAndPoliticsLegislation: nil,
                                armedForcesAndNatlSecurityLegislation: nil,
                                congressLegislation: nil,
                                intlAffairsLegislation: nil,
                                publicLandsNatResourcesLegislation: nil,
                                foreignTradeAndIntlFinanceLegislation: nil,
                                crimeAndLawEnforcementLegislation: nil,
                                transportationAndPublicWorksLegislation: nil,
                                educationLegislation: nil,
                                socialWelfareLegislation: nil,
                                energyLegislation: nil,
                                twentyTwelveContributors: nil,
                                twentyFourTeenContributors: nil,
                                twentySixTeenContributors: nil,
                                twentyEightTeenContributors: nil,
                                twentyTwentyContributors: nil,
                                twentyTwentyTwoContributors: nil
                            )
    
        sutRepContributorVM = RepContributorsViewModel(user: mockUser, openSecretsService: mockOpenSecretsService, official: mockOfficial)
    }
    
    override func tearDownWithError() throws {
        mockOpenSecretsService = nil
        mockUser = nil
        mockOfficial = nil
        sutRepContributorVM = nil
    }
    
    
    func testSuccessfulOpenSecretsAPIRequestTwentyTwentyTwoContributorNames() throws {
        
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![0].attributes.orgName, "Votesane PAC")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![1].attributes.orgName, "American Israel Public Affairs Cmte")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![2].attributes.orgName, "DISH Network")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![3].attributes.orgName, "Apollo Global Management")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![4].attributes.orgName, "Kit Bond Strategies")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![5].attributes.orgName, "Cox Enterprises")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![6].attributes.orgName, "NextEra Energy")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![7].attributes.orgName, "Comcast Corp")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![8].attributes.orgName, "NorPAC")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyTwoContributors![9].attributes.orgName, "Berkshire Hathaway")


    }
    
    
    func testSuccessfulOpenSecretsAPIRequestTwentyTwentyContributorNames() throws {
        
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![0].attributes.orgName, "Burns & McDonnell")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![1].attributes.orgName, "Ciciora Custom Homes")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![2].attributes.orgName, "Bartlett Grain")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![3].attributes.orgName, "Spirit Aerosystems")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![4].attributes.orgName, "Kansas City Southern")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![5].attributes.orgName, "BNSF Railway")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![6].attributes.orgName, "Koch Industries")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![7].attributes.orgName, "Van Scoyoc Assoc")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![8].attributes.orgName, "Polsinelli PC")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwentyContributors![9].attributes.orgName, "DISH Network")


    }
    
    
    func testSuccessfulOpenSecretsAPIRequestTwentyTwelveContributorNames() throws {
        
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![0].attributes.orgName, "Koch Industries")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![1].attributes.orgName, "Hallmark Cards")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![2].attributes.orgName, "Ciciora Custom Homes")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![3].attributes.orgName, "Polsinelli PC")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![4].attributes.orgName, "Watco Companies")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![5].attributes.orgName, "CME Group")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![6].attributes.orgName, "BNSF Railway")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![7].attributes.orgName, "Kansas City Southern")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![8].attributes.orgName, "California Rice Industry Assn")
        XCTAssertEqual(sutRepContributorVM!.official.twentyTwelveContributors![9].attributes.orgName, "Bartlett Grain")


    }
    
    
    
    func testSuccessfulOpenSecretsAPIRequestContributorTotals() throws {
        //XCTAssertEqual(sutRepsVM!.senatorOne.contributors![0].attributes.total, "$144,400.00")
        
    }
    
    
}







