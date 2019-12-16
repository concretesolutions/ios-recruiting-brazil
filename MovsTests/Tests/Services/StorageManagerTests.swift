//
//  StorageManagerTests.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 15/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import XCTest
import Quick
import Nimble
import CoreData
@testable import Movs

class StorageManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: type(of: self))
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [bundle])!
        return managedObjectModel
    }()
    var container: NSPersistentContainerMock!
    var sut: StorageManager!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.container = NSPersistentContainerMock(name: "MovsTests", managedObjectModel: self.managedObjectModel)
        self.container.addDataStubs()
        self.sut = StorageManager(container: self.container)
    }
    
    override func tearDown() {
        self.container.flushData()
        self.sut = nil
        self.container = nil
    }
    
    // MARK: - Container Management Tests
    
    func testShouldCreateEntityForValidName() {
        do {
            _ = try self.sut.createEntity(named: "CDFavoriteMovie")
            _ = succeed()
        } catch is StorageManager.CreationError {
            fail("Expected successful creation of entity CDFavoriteMovie.")
        } catch {
            fatalError("Unexpected error while trying to create entity with valid description")
        }
    }
    
    func testShouldFailEntityCreationForInvalidName() {
        do {
            _ = try self.sut.createEntity(named: "CDInvalidEntity")
            fail("Expected call to throw CreationError for invalid entity.")
        } catch is StorageManager.CreationError {
            _ = succeed()
        } catch {
            fatalError("Unexpected error while trying to create entity with invalid description")
        }
    }
    
    func testShouldFetchEntitiesForValidRequest() {
        let fetchAllFavorites = NSFetchRequest<Movs.CDFavoriteMovie>(entityName: "CDFavoriteMovie")
        do {
            let fetchResults = try self.sut.fetch(request: fetchAllFavorites)
            expect(fetchResults.count).to(equal(5))
        } catch {
            fail()
        }
    }
    
    func testShouldSaveContextIfChanged() {
        let saveExpectation = expectation(description: "Expected context to be saved")
        self.container.waitForSavedNotification { _ in
            saveExpectation.fulfill()
        }
        
        self.container.addDataStubs()
        self.sut.save()

        wait(for: [saveExpectation], timeout: 2.5)
    }
    
    func testShouldntSaveContextIfNotChanged() {
        let saveUnexpectation = expectation(description: "Expected context not to be saved")
        saveUnexpectation.isInverted = true
        self.container.waitForSavedNotification { _ in
            saveUnexpectation.fulfill()
        }

        self.sut.save()

        wait(for: [saveUnexpectation], timeout: 2.5)
    }
    
    // MARK: - Instace Management tests
    
    func testShouldAddMovieToFavorites() {
        let movie = Movie(id: 100, backdropPath: "", genres: Set(), posterPath: "", releaseDate: "2000-01-01", title: "", summary: "")
        
        self.sut.addFavorite(movie: movie)
        let favoriteIDs = self.sut.favorites.map({ $0.id })
        
        expect(favoriteIDs).to(contain(Int64(100)))
    }
    
    func testShouldRemoveFavoritedIDFromFavorites() {
        let removedID = Int64(3)
        
        self.sut.removeFavorite(movieID: removedID)
        
        let fetchAllFavorites = NSFetchRequest<Movs.CDFavoriteMovie>(entityName: "CDFavoriteMovie")
        let fetchResults: Set<Movs.CDFavoriteMovie>
        do {
            fetchResults = try self.sut.fetch(request: fetchAllFavorites)
        } catch {
            fatalError("Failed to fetch IDs")
        }
        
        let favoritedIDs = self.sut.favorites.map({ $0.id })
        let fetchedFavoritedIDs = fetchResults.map({ $0.id })
        
        expect(favoritedIDs).notTo(contain(removedID))
        expect(fetchedFavoritedIDs).notTo(contain(removedID))
    }
    
    func testShouldSignalFavoritedMovie() {
        let isFavorited = self.sut.isFavorited(movieID: 3)
        expect(isFavorited).to(beTrue())
    }
    
    func testShouldSignalNotFavoritedMovie() {
        let isFavorited = self.sut.isFavorited(movieID: 10)
        expect(isFavorited).to(beFalse())
    }
}
