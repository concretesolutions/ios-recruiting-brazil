//
//  MovsTests.swift
//  MovsTests
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import XCTest
@testable import Movs

class MovsTests: XCTestCase {
    
    var moduleMovies: MoviesRouter!
    var moduleMovieDetails: MovieDetailsRouter!
    var moduleFavorites: FavoritesRouter!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.moduleMovies = MoviesRouter.init()
        self.moduleMovieDetails = MovieDetailsRouter.init(id: 335983)
        self.moduleFavorites = FavoritesRouter.init()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModuleMovies() {
        // Router
        XCTAssertNotNil(moduleMovies)
        // Router References
        XCTAssertNotNil(moduleMovies.presenter)
        // Presenter References
        XCTAssertNotNil(moduleMovies.presenter.view)
        XCTAssertNotNil(moduleMovies.presenter.interactor)
        XCTAssertNotNil(moduleMovies.presenter.router)
        // View References
        XCTAssertNotNil(moduleMovies.presenter.view.presenter)
        // Interactor References
        XCTAssertNotNil(moduleMovies.presenter.interactor.presenter)
    }
    
    func testModuleMovieDetails() {
        // Router
        XCTAssertNotNil(moduleMovieDetails)
        // Router References
        XCTAssertNotNil(moduleMovieDetails.presenter)
        // Presenter References
        XCTAssertNotNil(moduleMovieDetails.presenter.view)
        XCTAssertNotNil(moduleMovieDetails.presenter.interactor)
        XCTAssertNotNil(moduleMovieDetails.presenter.router)
        // View References
        XCTAssertNotNil(moduleMovieDetails.presenter.view.presenter)
        // Interactor References
        XCTAssertNotNil(moduleMovieDetails.presenter.interactor.presenter)
    }
    
    func testModuleFavorites() {
        // Router
        XCTAssertNotNil(moduleFavorites)
        // Router References
        XCTAssertNotNil(moduleFavorites.presenter)
        // Presenter References
        XCTAssertNotNil(moduleFavorites.presenter.view)
        XCTAssertNotNil(moduleFavorites.presenter.interactor)
        XCTAssertNotNil(moduleFavorites.presenter.router)
        // View References
        XCTAssertNotNil(moduleFavorites.presenter.view.presenter)
        // Interactor References
        XCTAssertNotNil(moduleFavorites.presenter.interactor.presenter)
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
