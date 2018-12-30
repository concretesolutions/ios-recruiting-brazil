//
//  movsUITests.swift
//  movsUITests
//
//  Created by Bruno Muniz Azevedo Filho on 28/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import XCTest

@testable import movs

class MovsUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testMovieGridFlow() {
        app.collectionViews.element(boundBy: 0)
            .buttons[Constants.Accessibility.favorite].firstMatch.tap()
		app.collectionViews.cells.element(boundBy: 0).tap()
        app.buttons[Constants.Accessibility.favorite].tap()
		app.navigationBars.buttons.element(boundBy: 0).tap()
    }

    func testFavoritesFlow() {
		app.tabBars.buttons["Favorites"].tap()

        if !app.tables.cells.element(boundBy: 0).exists {
            app.tabBars.buttons["Movies"].tap()
            app.collectionViews.element(boundBy: 0).buttons[Constants.Accessibility.favorite].firstMatch.tap()
            app.tabBars.buttons["Favorites"].tap()
        }

        let element = app.staticTexts["2018"]
        let start = element.coordinate(withNormalizedOffset: CGVector(dx: 5, dy: 0))
        let finish = element.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        start.press(forDuration: 0, thenDragTo: finish)

        app.buttons["Unfavorite"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
		app.tables.cells.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.buttons["Apply"].tap()
        app.buttons["Remove filters"].tap()
        app.tabBars.buttons["Movies"].tap()
    }
}
