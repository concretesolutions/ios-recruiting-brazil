//
//  CoreDataManagerTests.swift
//  ios-recruiting-brazilTests
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import XCTest
@testable import ios_recruiting_brazil

class CoreDataManagerTests: XCTestCase {
    let manager = CoreDataManager()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager.saveMovie(name: "Teste", genres: "Action", overview: "Teste Overview", date: "0000/00/00", image: nil)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manager.resetCoreData()
    }
    
    func testFetchMovies() {
        let movies = manager.fetchMovies()
        XCTAssert(movies!.count > 0)
    }
    
    func testResetCoreData() {
        manager.resetCoreData()
        let movies = manager.fetchMovies()
        XCTAssertNotNil(movies)
    }
    
    func testSaveMovie() {
        manager.saveMovie(name: "Teste2", genres: "Action", overview: "Teste Overview", date: "0000/00/00", image: nil)
        let movies = manager.fetchMovies()
        XCTAssert(movies?.count == 2)
    }
    
    func testSearchMovieSuccess() {
        let movie = manager.searchForMovie(withName: "Teste")
        XCTAssertNotNil(movie)
    }
    
    func testSearchMoviesFail() {
        let movie = manager.searchForMovie(withName: "Wrong name")
        XCTAssertNil(movie)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
