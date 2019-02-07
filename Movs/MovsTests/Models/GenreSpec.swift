//
//  GenreSpec.swift
//  MovsTests
//
//  Created by Brendoon Ryos on 07/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Quick
import Nimble
@testable import Movs

class GenreSpec: QuickSpec {
  override func spec() {
    describe("a genre") {
      var genre: Genre!
      
      beforeEach {
        let sampleData = MovsAPI.fetchGenres.sampleData
        let genresData = try? JSONDecoder().decode(GenresData.self, from: sampleData)
        genre = genresData?.genres.first
      }
      
      it("should be able to create a genre from json") {
        expect(genre).notTo(beNil())
      }
      it("should have an id") {
        expect(genre.id).notTo(beNil())
      }
      it("should have a name") {
        expect(genre.name).notTo(beNil())
      }
    }
  }
}
