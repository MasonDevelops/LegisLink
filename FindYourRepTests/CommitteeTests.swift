//
//  CommitteeTests.swift
//  FindYourRepTests
//
//  Created by Mason Cochran on 6/30/24.
//


import XCTest

@testable import LegisLink

final class CommitteeTests: XCTestCase {
    
    var mockOpenStatesService: MockOpenStatesService!
    
    var mockUser: User!
    
    var mockOfficial: Official!

    
    var sutCommitteeVM: RepCommitteesViewModel?

    override func setUpWithError() throws {
        
        mockOpenStatesService = MockOpenStatesService()


        
        mockUser = User(id: "test_user_0", email: "test_user123@email.com", picture: "photoURL", street_address: "1263 Pacific Avenue", city: "Kansas City", state: "KS", zip_code: "66102")
        
        
        mockOfficial = Official(name: "Jerry Moran", chamber: "Senate",
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
                                    [:],
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
        
        
        
    
        sutCommitteeVM = RepCommitteesViewModel(user: mockUser, openStatesService: mockOpenStatesService!, official: mockOfficial)
    }

    override func tearDownWithError() throws {
        mockOpenStatesService = nil
        mockUser = nil
        mockOfficial = nil
        sutCommitteeVM = nil
    }
    
    
    
    func testSuccessfulOpenStatesAPIRequest() throws {

        XCTAssertEqual(sutCommitteeVM!.official.committees!["Senate Committee on Appropriations"], "Member")
        XCTAssertEqual(sutCommitteeVM!.official.committees!["Senate Committee on Commerce, Science, and Transportation"], "Member")
        XCTAssertEqual(sutCommitteeVM!.official.committees!["Senate Committee on Veterans' Affairs"], "Ranking Member")
        XCTAssertEqual(sutCommitteeVM!.official.committees!["Senate Select Committee on Intelligence"], "Member")

    }
}
