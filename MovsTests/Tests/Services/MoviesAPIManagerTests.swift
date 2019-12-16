//
//  MoviesAPIManagerTests.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 15/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Movs

class MoviesAPIManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: MoviesAPIManager!
    var mockedSession: URLSessionMock!
    var bundle: Bundle!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.mockedSession = URLSessionMock()
        self.sut = MoviesAPIManager(session: self.mockedSession)
        self.bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        self.sut = nil
        self.mockedSession = nil
        self.bundle = nil
    }
    
    // MARK: - Tests
       
    func testShouldSignalToFetchPopularMovies() {
        self.sut.currentPage = 100
        self.sut.isMovieFetchInProgress = false
    
        let signal = self.sut.shouldFetchNextPage()
        expect(signal).to(beTrue())
    }
       
    func testShouldntSignalToFetchPopularMoviesWhenNoNextPage() {
        self.sut.currentPage = 510
        self.sut.isMovieFetchInProgress = false
           
        let signal = self.sut.shouldFetchNextPage()
        expect(signal).to(beFalse())
    }
       
    func testShouldntSignalToFetchPopularMoviesWithFetchInProgress() {
        self.sut.currentPage = 100
        self.sut.isMovieFetchInProgress = true
           
        let signal = self.sut.shouldFetchNextPage()
        expect(signal).to(beFalse())
    }
    
    func testShouldFetchGenresListWithData() {
        let genres = [GenreDTO(id: 28, name: "Action"), GenreDTO(id: 30, name: "Drama"), GenreDTO(id: 32, name: "Horror")]
        do {
            let path = self.bundle.path(forResource: "GenresAPIData", ofType: "json")!
            self.mockedSession.data = try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            fatalError()
        }
        
        self.sut.fetchGenresList()
        expect(self.sut.genres).to(equal(genres))
    }
    
    func testShouldFetchPopularMoviesWithData() {
        let movies = [MovieDTO(id: 297761, backdropPath: nil, genreIDS: [28, 32], popularity: 48.261451, posterPath: nil, releaseDate: "2016-08-03", title: "Suicide Squad", overview: "Example overview.")]
        do {
            let path = self.bundle.path(forResource: "PopularMoviesAPIData", ofType: "json")!
            self.mockedSession.data = try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            fatalError()
        }
        
        self.sut.fetchNextPopularMoviesPage()
        expect(self.sut.movies).to(equal(movies))
    }
}
