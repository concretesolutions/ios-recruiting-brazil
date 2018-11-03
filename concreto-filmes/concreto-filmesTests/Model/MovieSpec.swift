//
//  MovieSpec.swift
//  concreto-filmesTests
//
//  Created by Leonel Menezes on 03/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import concreto_filmes

class MovieSpec: QuickSpec {
    override func spec() {
        describe("Test movie initialization") {
            let movieRealm: MovieRealm = MovieRealm(id: 12, posterPath: "asdf", title: "asdf", releaseDate: Date(), overview: "asdf", genres: ["terror", "zoeira"])
            
            it("Should initialize a movie based on a realm movie", closure: {
                let movie = Movie(movie: movieRealm)
                expect(movie).toNot(beNil())
                expect(movie.title).to(match(movieRealm.title))
                expect(movieRealm.genres).to(contain(movie.genres))
                expect(movie.overview).to(match(movieRealm.overview))
                expect(movie.posterPath).to(match(movieRealm.posterPath))
            })
            
        }
        
        describe("Test realm movie initialization") {
            let movie: Movie = Movie(id: 12, posterPath: "asdf", title: "asdf", releaseDate: Date(), overview: "asdf", genres: ["drama", "felicidade"])
            
            it("should initialize a realm movie based on a regular movie object", closure: {
                let realmMovie = MovieRealm(movie: movie)
                expect(realmMovie).toNot(beNil())
                expect(realmMovie.title).to(match(movie.title))
                expect(realmMovie.genres).to(contain(movie.genres))
                expect(realmMovie.overview).to(match(movie.overview))
                expect(realmMovie.posterPath).to(match(movie.posterPath))
            })
        }
    }
}
