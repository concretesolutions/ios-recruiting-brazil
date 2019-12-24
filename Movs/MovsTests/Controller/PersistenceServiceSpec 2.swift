//
//  PersistenceServiceSpec.swift
//  MovsTests
//
//  Created by Lucca França Gomes Ferreira on 19/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

class PersistenceServiceSpec: QuickSpec {

    override func spec() {
        describe("PersistenceService") {
            
            describe("toggleFavorite is called") {
                var movieDTO: MovieDTO!
                var movie: Movie!
                beforeEach {
                    movieDTO = MovieDTO(id: 1, overview: "", releaseDate: "", genreIds: [], title: "", posterPath: nil)
                    movie = Movie(withMovie: movieDTO)
                }
                context("when the movie isn't in favorites") {
                    beforeEach {
                        PersistenceService.toggleFavorite(movie)
                    }
                    it("favoriteMovies contains only one movie.id") {
                        let moviesWithSameID = PersistenceService.favoriteMovies.filter { $0 == movie.id }
                        expect(moviesWithSameID.count).to(equal(1))
                    }
                    
                }
                context("when the movie is in favorites") {
                    beforeEach {
                        PersistenceService.toggleFavorite(movie)
                        PersistenceService.toggleFavorite(movie)
                    }
                    it("favoriteMovies does not contain movie.id") {
                        let moviesWithSameID = PersistenceService.favoriteMovies.filter { $0 == movie.id }
                        expect(moviesWithSameID.count).to(equal(0))
                    }
                }
            }
        }
    }
    
}
