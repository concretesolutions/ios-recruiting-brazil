//
//  DataServiceTest.swift
//  movsTests
//
//  Created by Emerson Victor on 22/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import XCTest
@testable import Movs

class DataServiceTest: XCTestCase {
    
    var dataService = DataService.shared
    var dataSource = DataSourceMock.self

    override func setUp() {
        super.setUp()
        self.dataService.reset()
        self.dataService.resetDefaults(with: "DataServiceTest")
        self.dataService.setup(with: DataSourceMock.self,
                               defaults: UserDefaults.init(suiteName: "DataServiceTest")!)
    }
    
    // MARK: - Load movies
    func testLoadMoviesFirstPageIsCorrect() {
        self.dataSource.setup(for: .loadSuccess)
        let expection = self.expectation(description: "LoadMovies")
        var stateReturned: CollectionState = .loadError
        
        self.dataService.loadMovies(of: 1) { (state) in
            stateReturned = state
            expection.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(stateReturned, .loadSuccess)
        XCTAssertEqual(self.dataService.movies.count, 3)
        XCTAssertEqual(self.dataService.genres.count, 4)
    }
    
    func testLoadMoviesSecondPageIsCorrect() {
        self.dataSource.setup(for: .loadSuccess)
        let expection = self.expectation(description: "LoadMovies")
        var stateReturned: CollectionState = .loadError
        
        self.dataService.loadMovies(of: 1) { (_) in
            self.dataService.loadMovies(of: 2) { (state) in
                stateReturned = state
                expection.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(stateReturned, .loadSuccess)
        XCTAssertEqual(self.dataService.movies.count, 6)
        XCTAssertEqual(self.dataService.genres.count, 4)
    }
    
    func testLoadMoviesIsIncorrect() {
        self.dataSource.setup(for: .loadError)
        let expection = self.expectation(description: "LoadMovies")
        var stateReturned: CollectionState = .loadSuccess
        
        self.dataService.loadMovies(of: 1) { (state) in
            stateReturned = state
            expection.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(stateReturned, .loadError)
        XCTAssert(self.dataService.movies.isEmpty)
        XCTAssert(self.dataService.genres.isEmpty)
    }
    
    // MARK: - Movie image
    func testLoadPosterImageIsCorrect() {
        self.dataSource.setup(for: .loadSuccess)
        let expection = self.expectation(description: "LoadPosterImage")
        var posterImage: UIImage?
        
        self.dataService.loadPosterImage(with: "") { (image) in
            posterImage = image
            expection.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        if let image = posterImage {
            XCTAssertEqual(image, UIImage())
        } else {
            XCTAssert(false)
        }
    }
    
    func testLoadPosterImageIsIncorrect() {
        self.dataSource.setup(for: .loadError)
        let expection = self.expectation(description: "LoadPosterImage")
        var posterImage: UIImage?
        
        self.dataService.loadPosterImage(with: "") { (image) in
            posterImage = image
            expection.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        if let image = posterImage {
            XCTAssertEqual(image, UIImage(named: "PosterUnavailabe")!)
        } else {
            XCTAssert(false)
        }
    }
    
    // MARK: - Favorites
    func testLoadFavorites() {
        self.dataSource.setup(for: .loadSuccess)
        let expection = self.expectation(description: "LoadFavorites")
        var stateReturned: CollectionState = .loadError
        self.dataService.addToFavorites(10)
        
        self.dataService.loadFavorites { (state) in
            stateReturned = state
            expection.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(stateReturned, .loadSuccess)
        XCTAssertEqual(self.dataService.favorites.count, 1)
    }
    
    func testAddToFavorites() {
        for i in 0...10 {
            self.dataService.addToFavorites(i)
        }
        
        XCTAssertEqual(self.dataService.favoritesIDs, Set(Array(0...10)))
    }
    
    func testRemoveFromFavorites() {
        self.dataService.addToFavorites(10)
        self.dataService.removeFromFavorites(10)
        
        XCTAssertEqual(self.dataService.favoritesIDs, Set([]))
    }
    
    func testMovieIsFavorite() {
        self.dataService.addToFavorites(10)
        XCTAssert(self.dataService.movieIsFavorite(10))
    }
}
