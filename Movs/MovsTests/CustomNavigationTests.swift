//
//  File.swift
//  MovsTests
//
//  Created by João Gabriel Borelli Padilha on 20/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import XCTest
@testable import Movs

class CustomNavigationTests: XCTestCase {
    
    var customNavigationFavorites: CustomNavigation!
    var customNavigationMovies: CustomNavigation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let favoritesView = FavoritesRouter.init().presenter.view
        self.customNavigationFavorites = CustomNavigation.init(viewController: favoritesView, title: "Favorites")
        
        let moviesView = MoviesRouter.init().presenter.view
        self.customNavigationMovies = CustomNavigation.init(viewController: moviesView, title: "Movies")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNavigationFavorites() {
        XCTAssertNotNil(self.customNavigationFavorites)
        // Title
        if let view = self.customNavigationFavorites.visibleViewController as? FavoritesView {
            XCTAssertEqual(view.navigationItem.title, "Favorites")
        }else{
            XCTFail("Missing Root ViewController on Navigtion")
        }
        // Filter button
        if let view = self.customNavigationFavorites.visibleViewController as? FavoritesView {
            XCTAssertNotNil(view.navigationItem.rightBarButtonItem)
        }else{
            XCTFail("Missing RightBarButtonItem")
        }
    }
    
    func testNavigationMovies() {
        XCTAssertNotNil(self.customNavigationFavorites)
        // Title
        if let view = self.customNavigationMovies.visibleViewController as? MoviesView {
            XCTAssertEqual(view.navigationItem.title, "Movies")
        }else{
            XCTFail("Missing Root ViewController on Navigtion")
        }
    }
    
}
