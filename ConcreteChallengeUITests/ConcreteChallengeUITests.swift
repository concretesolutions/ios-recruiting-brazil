//
//  ConcreteChallengeUITests.swift
//  ConcreteChallengeUITests
//
//  Created by Erick Pinheiro on 03/05/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import XCTest

class ConcreteChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFavoriteUnfavoriteFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments += ["UITesting"]
        app.launch()

        let tabBar = app.tabBars.firstMatch
        
        tabBar.buttons["Favorites"].tap()
        
        var favoritesTable = app.tables["Favorites::TableView"].waitForExistence(timeout: 10)
        
        var initialFavorites = app.tables["Favorites::TableView"].cells.count
        
        guard initialFavorites == 0 else {
            XCTFail("Favorites not initially empty")
            return
        }
        
        tabBar.buttons["Movies"].tap()
        
        let firstCell = app.collectionViews["Movies::CollectionView"].cells.firstMatch.waitForExistence(timeout: 10)
        
        guard firstCell else {
            XCTFail("Movies not created")
            return
        }
        
        app.collectionViews["Movies::CollectionView"].cells.firstMatch.tap()
        
        let favoriteExists = app.buttons["MovieDetails::Favorites"].waitForExistence(timeout: 5)
        
        
        guard favoriteExists else {
            XCTFail("Favorites button not created")
            return
        }

        
        app.buttons["MovieDetails::Favorites"].tap()
        
        tabBar.buttons["Favorites"].tap()
        
                
        let favoritesCountShouldBeOne = app.tables["Favorites::TableView"].cells.count
        
        guard favoritesCountShouldBeOne == 1 else {
            XCTFail("Favorites not working")
            return
        }
        
        let firstFavoriteItem = app.tables["Favorites::TableView"].cells.element(boundBy: 0)
        firstFavoriteItem.swipeLeft()
        firstFavoriteItem.buttons["Unfavorite"].tap()
        
        
        XCTAssertTrue(app.tables["Favorites::TableView"].cells.count == 0, "Favorite swipe delete not working")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
