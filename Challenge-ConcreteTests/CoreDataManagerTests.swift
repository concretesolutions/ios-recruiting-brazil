//
//  CoreDataManagerTests.swift
//  Challenge-ConcreteTests
//
//  Created by João Paulo de Oliveira Sabino on 16/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import XCTest
@testable import Challenge_Concrete
class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var movie: FavoriteMovie!
    override func setUp() {
        coreDataManager = CoreDataManager()
        movie = FavoriteMovie(context: coreDataManager.persistentContainer.viewContext,
                              id: 1, title: "Mock Movie", year: "2019", descript: "Description", image: Data(), genres: [])
        coreDataManager.saveContext()
        continueAfterFailure = false

    }

    
    override func tearDown() {
        coreDataManager = nil
    }

    func testFetchRequest() {
        let movies: [FavoriteMovie] = coreDataManager.fetch()
        XCTAssertTrue(movies.contains(movie))
    }
    
    func testFetchById() {
        let movie: FavoriteMovie? = coreDataManager.fetchBy(id: 1)
        XCTAssertNotNil(movie)
    }
    
    func testSave() {
        _ = FavoriteMovie(context: coreDataManager.persistentContainer.viewContext,
                          id: 99, title: "Title", year: "2019", descript: "Descript", image: Data(), genres: [])
        coreDataManager.saveContext()
        let movie: FavoriteMovie? = coreDataManager.fetchBy(id: 99)
        XCTAssertNotNil(movie)
    }
    
    func testDeleteAll() {
        coreDataManager.delete(entityType: FavoriteMovie.self)
        let movies: [FavoriteMovie] = coreDataManager.fetch()
        XCTAssertEqual(movies.count, 0)
    }
    
    func testDeleteById() {
        coreDataManager.deleteBy(id: 1, entityType: FavoriteMovie.self)
        let movie: FavoriteMovie? = coreDataManager.fetchBy(id: 1)
        XCTAssertNil(movie)
    }
}
