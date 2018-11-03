//
//  concreto_filmesUITests.swift
//  concreto-filmesUITests
//
//  Created by Leonel Menezes on 30/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import XCTest

class concreto_filmesUITests: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments += ["UI-Testing"]
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigationFLow() {
        
        app.tabBars.buttons["Favoritos"].tap()
        app.navigationBars["concreto_filmes.FavoritesView"].buttons["Filter"].tap()
        app.buttons["Aplicar"].tap()
        XCUIDevice.shared.orientation = .faceUp
        
    }
    
    func testFavoriteMovieActionFlow() {

        let collectionViewsQuery = app.collectionViews
        let element = collectionViewsQuery.cells.firstMatch.children(matching: .other).element
        element.tap()
        
        let favoriteGrayIconButton = app.buttons["favorite gray icon"]
        favoriteGrayIconButton.tap()
        let favoriteFullIconButton = app.buttons["favorite full icon"]
        favoriteFullIconButton.tap()
        
    }
    
    func testAcessMovieDetailByFavorites() {
        let collectionViewsQuery = app.collectionViews
        let element = collectionViewsQuery.cells.firstMatch
        let identifier = element.identifier
        element.tap()
        app.buttons["favorite gray icon"].tap()
        
        app.navigationBars["concreto_filmes.MovieDetailView"].buttons["Back"].tap()
        app.tabBars.buttons["Favoritos"].tap()
        app.navigationBars["concreto_filmes.FavoritesView"].searchFields["Search"].tap()
        
        UIPasteboard.general.string = identifier
        
        app.navigationBars["concreto_filmes.FavoritesView"].searchFields["Search"].doubleTap()
        app/*@START_MENU_TOKEN@*/.menuItems["Paste"]/*[[".menus.menuItems[\"Paste\"]",".menuItems[\"Paste\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.staticTexts[identifier].doubleTap()
        
        app.buttons["favorite full icon"].tap()
        app.navigationBars["concreto_filmes.MovieDetailView"].buttons["Back"].tap()
        
    }
    
    func testLocalSearch() {
        let collectionViewsQuery = app.collectionViews
        let element = collectionViewsQuery.cells.firstMatch
        let identifier = element.identifier
        
        let searchBar = app.navigationBars["concreto_filmes.MainScreenView"].searchFields["Search"]
        searchBar.tap()
        
        searchBar.typeText(identifier)
        
        let updatedElement = collectionViewsQuery.cells.firstMatch
        
        XCTAssert(updatedElement.identifier == identifier)
        
    }

}
