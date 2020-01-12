//
//  PlistFavoritesManagerTests.swift
//  ConcreteRecruitingTests
//
//  Created by Alysson Moreira on 12/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import XCTest
@testable import ConcreteRecruiting

class PlistFavoritesManagerTests: XCTestCase {
    
    let favoritesManager = PListFavoritesManager()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try? FileManager.default.removeItem(atPath: self.favoritesManager.favoritesPath)
    }

    func testGetEmptyFavorites() {
        let favorites = self.favoritesManager.getAllFavorites()
        
        XCTAssertTrue(favorites.isEmpty)
        
    }
    
    func testSaveFavorite() {
       
        var favorites = self.favoritesManager.getAllFavorites()
        
        XCTAssertTrue(favorites.isEmpty)
        
        let movie = Movie(id: 1)
        self.favoritesManager.addFavorite(movie)
        
        favorites = self.favoritesManager.getAllFavorites()
        let numberOfFavorites = favorites.count
        
        XCTAssertEqual(numberOfFavorites, 1)
        
    }
    
    func testNotSaveDuplicateFavorite() {
        
        var favorites = self.favoritesManager.getAllFavorites()
        
        XCTAssertTrue(favorites.isEmpty)
        
        let movies = Array.init(repeating: Movie(id: 2), count: 10)
        
        for movie in movies {
            self.favoritesManager.addFavorite(movie)
        }
        
        favorites = self.favoritesManager.getAllFavorites()
        let numberOfFavorites = favorites.count
        
        XCTAssertEqual(numberOfFavorites, 1)
        
    }
    
    func testRemoveFavorite() {
        
        let movie = Movie(id: 3)
        self.favoritesManager.addFavorite(movie)
        
        var favorites = self.favoritesManager.getAllFavorites()
        var numberOfFavorites = favorites.count
        
        XCTAssertEqual(numberOfFavorites, 1)
        
        self.favoritesManager.removeFavorite(movie)
        
        favorites = self.favoritesManager.getAllFavorites()
        numberOfFavorites = favorites.count
        
        XCTAssertEqual(numberOfFavorites, 0)
        
    }
    
    func testCheckFavoritePresence() {
        
        let movie = Movie(id: 3)
        self.favoritesManager.addFavorite(movie)
        
        XCTAssertEqual(self.favoritesManager.checkForPresence(of: movie), true)
        
    }
    
}
