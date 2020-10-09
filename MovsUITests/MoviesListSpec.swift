//
//  MoviesListSpec.swift
//  MovsUITests
//
//  Created by Joao Lucas on 09/10/20.
//

import XCTest

class MoviesListSpec: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testVerifyItemInCell() {
        let item = app.collectionViews.cells.staticTexts["Enola Holmes"]
        XCTAssertTrue(item.exists)
    }
}
