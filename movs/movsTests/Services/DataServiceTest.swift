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

    override func setUp() {
        super.setUp()
        self.dataService.reset()
        self.dataService.resetDefaults(with: "DataServiceTest")
        self.dataService.setup(with: DataSourceMock.self,
                               defaults: UserDefaults.init(suiteName: "DataServiceTest")!)
    }
    
    func testLoadMovies() {
        
    }
    
    func testLoadFavorites() {
        
    }
    
    func testLoadPosterImage() {
        
    }
    
    func testAddToFavorites() {
        
    }
    
    func testRemoveFromFavorites() {
        
    }
    
    func testMovieIsFavorite() {
        
    }
}

//private(set) var genres: [Int: String] = [:]
//private(set) var dataSource: DataSource.Type
//private(set) var movies: [Movie]
//private(set) var favorites: [Movie]
//private var favoritesIDs: Set<Int>
