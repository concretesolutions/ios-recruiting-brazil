//
//  MovsUITests.swift
//  MovsUITests
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import XCTest

class MovsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicNavigation() {
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.firstMatch.tap()
        app.navigationBars["Movie"].buttons["Movies"].tap()
        app.tabBars.buttons["Favorites"].tap()
    }

}
