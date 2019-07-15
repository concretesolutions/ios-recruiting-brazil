//
//  FavoritesProvider.swift
//  MovieTests
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import XCTest
@testable import Movie

class FavoritesProvider: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddFavorite() {
   
        let sut = UserDefaultsFavoriteProvider()
        
        let added = sut.addNew(withId: Int.random(in: 0...Int.max))
        
        XCTAssert(!added.isEmpty)
    
        
    }
    
    func testRemoveFavorite() {
        
        let sut = UserDefaultsFavoriteProvider()
        
        XCTAssertNotNil(sut.delete(withId: Int.random(in: 0...Int.max)))

    }
    
    func testGetAllFavorites() {
        
        let sut = UserDefaultsFavoriteProvider()
        
        XCTAssertNotNil(sut.getAllIds())
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
