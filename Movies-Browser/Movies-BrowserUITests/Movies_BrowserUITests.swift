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
    
    // MARK: - Test Tabs
    func testTapFavoritesTab() {
        app.tabBars.buttons["Favorites"].tap()
        XCTAssert(app.navigationBars["Favorites"].exists)
        snapshot("1-FavoritesTabTap")
    }
    
    func testTapFavoritesTabAndFeaturedTab() {
        app.tabBars.buttons["Favorites"].tap()
        app.tabBars.buttons["Movies"].tap()
        XCTAssert(app.navigationBars["Movies"].exists)
        snapshot("2-FavoritesTabTapAndFeaturedTabTap")
    }
    
    // MARK: - Favorite a Movie Test
    func testFavoriteAMovie(){
        app.collectionViews.firstMatch.cells.firstMatch.tap()
        let addFavoriteButtonExists = app.buttons["Add to the favorite list"].exists
        if addFavoriteButtonExists {
            app.buttons["Add to the favorite list"].tap()
        }
        XCTAssert(app.buttons["Remove from the favorite list"].exists)
        snapshot("3-FavoriteAMovie")
    }
    
    func testUnfavoriteAMovie(){
        app.collectionViews.firstMatch.cells.firstMatch.tap()
        let unfavoriteButtonExists = app.buttons["Remove from the favorite list"].exists
        if unfavoriteButtonExists {
            app.buttons["Remove from the favorite list"].tap()
        } else {
            app.buttons["Add to the favorite list"].tap()
            app.buttons["Remove from the favorite list"].tap()
        }
        XCTAssert(app.buttons["Add to the favorite list"].exists)
        snapshot("4-UnfavoriteAMovie")
    }
       
    
    // MARK: - Search Test for Featured Movies
    func testSearchNotAvailableForFeaturedMovies() {
        app.searchFields["Search for a movie (ex: Batman)"].clearAndEnterText(text: "Eu não existo")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(for: 5.0)
        XCTAssert(app.staticTexts["🧐"].exists)
        snapshot("5-SearchEmptyStateForFeaturedMovies")
    }
    
    func testSearchAvailableForFeaturedMovies() {
        app.searchFields["Search for a movie (ex: Batman)"].clearAndEnterText(text: "Ad")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(for: 5.0)
        XCTAssert(!app.staticTexts["🧐"].exists)
        snapshot("6-SearchResultsStateForFeaturedMovies")
    }
    
    // MARK: - Search Test for Favorite Movies
    func testSearchNotAvailableForFavoriteMovies() {
        testFavoriteAMovie()
        app.navigationBars.firstMatch.buttons["Movies"].tap()
        app.tabBars.buttons["Favorites"].tap()
        app.searchFields["Search for a movie (ex: Inception)"].clearAndEnterText(text: "Eu não existo")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(for: 5.0)
        XCTAssert(app.staticTexts["🧐"].exists)
        snapshot("7-SearchEmptyStateForFavoriteMovies")
    }
    
    func testSearchAvailableForFavoriteMovies() {
        testFavoriteAMovie()
        app.navigationBars.firstMatch.buttons["Movies"].tap()
        app.tabBars.buttons["Favorites"].tap()
        app.searchFields["Search for a movie (ex: Inception)"].clearAndEnterText(text: "Ad")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(for: 5.0)
        XCTAssert(!app.staticTexts["🧐"].exists)
        snapshot("8-SearchResultsStateForFavoriteMovies")
    }
    
    // MARK: - Empty State for Favorite Movies
    func testEmptyStateForFavoriteMovies() {
        testUnfavoriteAMovie()
        app.navigationBars.firstMatch.buttons["Movies"].tap()
        app.tabBars.buttons["Favorites"].tap()
        XCTAssert(app.staticTexts["🥺"].exists)
        snapshot("9-SearchEmptyStateForFavoriteMovies")
    }
}
