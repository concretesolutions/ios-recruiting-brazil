//
//  MovieResponseSpec.swift
//  moviesTests
//
//  Created by Jacqueline Alves on 11/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieResponseSpec: QuickSpec {
    override func spec() {
        var sut: MoviesResponse!
        let dateFormatter = DateFormatter()
        
        describe("the 'Movie Reponse' ") {
            context("when decoded with all values ") {
                beforeEach {
                    sut = try? MovieService.jsonDecoder.decode(MoviesResponse.self, from: movieResponseComplete)
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                }
                
                it("should not be nil.") {
                    expect(sut).notTo(beNil())
                }
                
                it("should have one movie.") {
                    expect(sut!.results.count).to(be(1))
                }
                
                it("should have a valid movie.") {
                    expect(sut!.results.first?.id).to(be(330457))
                    expect(sut!.results.first?.title).to(equal("Frozen II"))
                    expect(sut!.results.first?.posterPath).to(equal("/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg"))
                    expect(sut!.results.first?.overview).to(equal("Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom."))
                    expect(sut!.results.first?.genreIds).to(equal([16, 10402, 10751]))
                    expect(sut!.results.first?.genres).to(beNil())
                    expect(sut!.results.first?.releaseDate).to(equal(dateFormatter.date(from: "2019-11-20")))
                }
            }
            
            context("when missing title, genre ids and poster path parameters ") {
                beforeEach {
                    sut = try? MovieService.jsonDecoder.decode(MoviesResponse.self, from: movieResponseMissingParameter)
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                }
                
                it("should not be nil.") {
                    expect(sut).notTo(beNil())
                }
                
                it("should have a non nil title.") {
                    expect(sut!.results.first?.title).toNot(beNil())
                }
                
                it("should have a nil poster path.") {
                    expect(sut!.results.first?.posterPath).to(beNil())
                }
                
                it("should have a nil genre ids.") {
                    expect(sut!.results.first?.genreIds).to(beNil())
                }
            }
            
            context("when missing value for release date ") {
                beforeEach {
                    sut = try? MovieService.jsonDecoder.decode(MoviesResponse.self, from: movieResponseMissingValue)
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                }
                
                it("should not be nil.") {
                    expect(sut).notTo(beNil())
                }
                
                it("should have a nil release date.") {
                    expect(sut!.results.first?.releaseDate).to(beNil())
                }
            }
        }
    }
}

// MARK: - Auxiliar variables
private let movieResponseComplete = Data("""
{
    "page": 1,
    "total_results": 1,
    "total_pages": 1,
    "results": [
      {
        "popularity": 293.123,
        "vote_count": 875,
        "video": false,
        "poster_path": "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg",
        "id": 330457,
        "adult": false,
        "backdrop_path": "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
        "original_language": "en",
        "original_title": "Frozen II",
        "genre_ids": [
          16,
          10402,
          10751
        ],
        "title": "Frozen II",
        "vote_average": 7.1,
        "overview": "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
        "release_date": "2019-11-20"
      }
    ]
}
""".utf8)

// Movie without title, genre ids and poster path
private let movieResponseMissingParameter = Data("""
{
    "page": 1,
    "total_results": 1,
    "total_pages": 1,
    "results": [
      {
        "popularity": 293.123,
        "vote_count": 875,
        "video": false,
        "id": 330457,
        "adult": false,
        "backdrop_path": "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
        "original_language": "en",
        "original_title": "Frozen II",
        "vote_average": 7.1,
        "overview": "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
        "release_date": "2019-11-20"
      }
    ]
}
""".utf8)

// Movie with empty release date
private let movieResponseMissingValue = Data("""
{
    "page": 1,
    "total_results": 1,
    "total_pages": 1,
    "results": [
      {
        "popularity": 293.123,
        "vote_count": 875,
        "video": false,
        "poster_path": "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg",
        "id": 330457,
        "adult": false,
        "backdrop_path": "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
        "original_language": "en",
        "original_title": "Frozen II",
        "genre_ids": [
          16,
          10402,
          10751
        ],
        "title": "Frozen II",
        "vote_average": 7.1,
        "overview": "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
        "release_date": ""
      }
    ]
}
""".utf8)
