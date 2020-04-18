//
//  Movies_BrowserUITests.swift
//  Movies-BrowserUITests
//
//  Created by Gustavo Severo on 17/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import XCTest

class Movies_BrowserUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        setupSnapshot(app)
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {}

    func testAppLaunch() {
        app.launch()
        snapshot("0-Launch")
    }
}
