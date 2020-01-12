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
        let favorites = favoritesManager.getAllFavorites()
        
        assert(favorites.isEmpty)
        
    }
    
    
    
}
