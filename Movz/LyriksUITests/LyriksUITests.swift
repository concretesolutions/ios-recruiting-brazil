//
//  LyriksUITests.swift
//  LyriksUITests
//
//  Created by Eduardo Pereira on 05/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import XCTest

class LyriksUITests: XCTestCase {

    override func setUp() {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
//        let label = app.collectionViews
//        let exists = NSPredicate(format: "exists == 1")
//        expectation(for: exists, evaluatedWith: label, handler: nil)
//        waitForExpectations(timeout: 10, handler: nil)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let app = XCUIApplication()
        snapshot("HomeCollection")
        app.navigationBars["Lyriks.View"]/*@START_MENU_TOKEN@*/.buttons["Table"]/*[[".segmentedControls.buttons[\"Table\"]",".buttons[\"Table\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("HomeTable")
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Search"].tap()
        snapshot("SearchMain")
        app.buttons["Find"].tap()
        snapshot("SearchResult")
        tabBarsQuery.buttons["Favorite"].tap()
        snapshot("Favorites")
        

      
        
     
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
