//
//  MovieSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class CoreDataHelperMock: CoreDataHelperProtocol {
    
    func newFavoriteMovie() -> FavoriteMovie {
        return FavoriteMovie()
    }
    
    func retrieveFavoriteMovies() -> [FavoriteMovie] {
        return [FavoriteMovie()]
    }
    
    func favoriteMovie(for id: Int) -> FavoriteMovie? {
        if id == 297761 {
            return nil
        }
        
        return FavoriteMovie()
    }
    
    func save() {
        print("oi")
    }
    
    func delete(favoriteMovie: FavoriteMovie) {
        print("oi")
    }
}

class MovieSpec: QuickSpec {
    override func spec() {
        
        let mockAPI = MockApiClient()
        var movies = [Movie]()
        var movie: Movie?
        
        describe("set up movie") {
            
            beforeEach {
                mockAPI.fetchMovies { (success, moviesResponse) in
                    movies = moviesResponse!.results
                }
                
                movie = movies.first!
            }
            
            it("check release year") {
                expect(movie!.releaseYear) == "2016"
            }
            
            it("check posterURL") {
                expect(movie!.posterURL) == URL(string: "https://image.tmdb.org/t/p/w500/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg")
            }
        }
    }
}

