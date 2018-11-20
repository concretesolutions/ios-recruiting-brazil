//
//  AppTabBarTests.swift
//  MovsTests
//
//  Created by João Gabriel Borelli Padilha on 20/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import XCTest
@testable import Movs

class AppTabBarTests: XCTestCase {
    
    var appTabBar: AppTabBar!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.appTabBar = AppTabBar()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTabBarStyle() {
        // TabBar
        XCTAssertNotNil(appTabBar)
        // Colors
        XCTAssertEqual(appTabBar.tabBar.barTintColor, ColorPallete.yellow)
        XCTAssertEqual(appTabBar.tabBar.tintColor, UIColor.black)
    }
    
    func testMovies() {
        if let tabMovies = appTabBar.viewControllers?[0] as? CustomNavigation {
            XCTAssertTrue(tabMovies.isKind(of: CustomNavigation.self))
            if let moduleMovies = tabMovies.viewControllers.first as? MoviesView {
                XCTAssertTrue(moduleMovies.isKind(of: MoviesView.self))
            }else{
                XCTFail("Missing MoviesView")
            }
        }else{
            XCTFail("Missing CustomNavigation")
        }
    }
    
    func testFavorites() {
        if let tabMovies = appTabBar.viewControllers?[1] as? CustomNavigation {
            XCTAssertTrue(tabMovies.isKind(of: CustomNavigation.self))
            if let moduleMovies = tabMovies.viewControllers.first as? FavoritesView {
                XCTAssertTrue(moduleMovies.isKind(of: FavoritesView.self))
            }else{
                XCTFail("Missing FavoritesView")
            }
        }else{
            XCTFail("Missing CustomNavigation")
        }
    }
    
}
