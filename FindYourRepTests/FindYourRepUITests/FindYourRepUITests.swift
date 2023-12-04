//
//  FindYourRepUITests.swift
//  FindYourRepUITests
//
//  Created by Mason Cochran on 8/3/23.
//

import XCTest

final class FindYourRepUITests: XCTestCase {
    
    let app = XCUIApplication()



    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app.launchEnvironment["Google_API_Key"] = "AIzaSyCgO3NR9RI4fH1WVUwZYhYqVf5rRY_q33k"
        app.launchEnvironment["OpenSecrets_API_Key"] = "3959d0a9628e0e56f61530a0b074a055"
        app.launchEnvironment["OpenStates_API_Key"] = "b2fcc267-65bd-48c5-9d1b-ed7f28e2bacd"


        app.launch()
    }

    override func tearDownWithError() throws {
        
    }

    func testNavigationToMyRepresentatives() throws {
        auth0ToMyRepresentatives()
        XCTAssert(app.staticTexts["Jerry Moran"].exists)
        XCTAssert(app.staticTexts["Roger Marshall"].exists)
        XCTAssert(app.staticTexts["Jake LaTurner"].exists)
    }
    
    func testNavigationToSenatorOne() throws {
        auth0ToMyRepresentatives()
        let senatorOneButton = app.buttons["Jerry Moran"]
        senatorOneButton.tap()
        let committeeButton = app.buttons["Jerry Moran's Committees"]
        XCTAssert(app.staticTexts["Twitter: @JerryMoran"].exists)
        XCTAssert(app.staticTexts["Facebook: @jerrymoran"].exists)
        XCTAssert(app.staticTexts["https://www.moran.senate.gov/"].exists)
        XCTAssert(app.staticTexts["https://en.wikipedia.org/wiki/Jerry_Moran"].exists)
        
        while !(committeeButton.exists) {

            app.swipeUp()

        }
        
        XCTAssert(app.staticTexts["Jerry Moran's Committees"].exists)
    }
    
    func testNavigationToSenatorTwo() throws {
        auth0ToMyRepresentatives()
        let senatorTwoButton = app.buttons["Roger Marshall"]
        senatorTwoButton.tap()
        let committeeButton = app.buttons["Roger Marshall's Committees"]
        XCTAssert(app.staticTexts["Twitter: @repmarshall"].exists)
        XCTAssert(app.staticTexts["Facebook: @RogerMarshallMD"].exists)
        XCTAssert(app.staticTexts["https://www.marshall.senate.gov/"].exists)
        XCTAssert(app.staticTexts["https://en.wikipedia.org/wiki/Roger_Marshall_%28politician%29"].exists)
        
        while !(committeeButton.exists) {

            app.swipeUp()

        }
        
        XCTAssert(app.staticTexts["Roger Marshall's Committees"].exists)
    }
    
    func testNavigationToRepresentative() throws {
        auth0ToMyRepresentatives()
        let repButton = app.buttons["Jake LaTurner"]
        repButton.tap()
        let committeeButton = app.buttons["Jake LaTurner's Committees"]
        XCTAssert(app.staticTexts["Twitter: @RepLaTurner"].exists)
        XCTAssert(app.staticTexts["Facebook: @CongressmanJakeLaTurner"].exists)
        XCTAssert(app.staticTexts["https://laturner.house.gov/"].exists)
        XCTAssert(app.staticTexts["https://en.wikipedia.org/wiki/Jake_LaTurner"].exists)
        
        while !(committeeButton.exists) {

            app.swipeUp()

        }
        
        XCTAssert(app.staticTexts["Jake LaTurner's Committees"].exists)
    }
    
    func auth0ToMyRepresentatives() {
        let loginAndRegister = app.buttons["Login & Register"]
        loginAndRegister.tap()
        sleep(5)
        addUIInterruptionMonitor(withDescription: "Auth0") {
            (alert) -> Bool in
            alert.buttons["Continue"].tap()
            return true
          }
        app.tap()
        let tabBar = app.tabBars["Tab Bar"]
        sleep(5)
        tabBar.buttons["My Representatives"].tap()
        sleep(5)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
