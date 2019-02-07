//
//  MovieSpec.swift
//  MovsTests
//
//  Created by Brendoon Ryos on 07/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

class MovieSpec: QuickSpec {
  override func spec() {
    describe("a movie") {
      var movie: Movie!
      
      beforeEach {
        let sampleData = MovsAPI.fetchPopularMovies(page: 1).sampleData
        let moviesData = try? JSONDecoder().decode(MoviesData.self, from: sampleData)
        movie = moviesData?.results.first
      }
      
      it("should be able to create a movie from json") {
        expect(movie).notTo(beNil())
      }
      it("should have an id") {
        expect(movie.id).notTo(beNil())
      }
      it("should have a title") {
        expect(movie.title).notTo(beNil())
      }
      it("should have an overview") {
        expect(movie.overview).notTo(beNil())
      }
      it("should have a releaseDate") {
        expect(movie.releaseDate).notTo(beNil())
      }
      it("should have genreIds") {
        expect(movie.genreIds).notTo(beNil())
      }
    }
  }
}


