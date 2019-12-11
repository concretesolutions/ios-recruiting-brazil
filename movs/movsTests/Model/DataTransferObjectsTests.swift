//
//  DataTransferObjectsTests.swift
//  movsTests
//
//  Created by Emerson Victor on 03/12/19.
//  Copyright © 2019 emer. All rights reserved.
//
// swiftlint:disable line_length force_try
import XCTest
@testable import movs

class DataTransferObjectsTests: XCTestCase {
    
    // Attributes
    var movieRequestDTO: MoviesRequestDTO!
    var genresDTO: GenresDTO!
    /// Mocked data
    let movieRequestData = Data("""
            {
              "page": 1,
              "results": [
                {
                  "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
                  "adult": false,
                  "overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
                  "release_date": "2016-08-03",
                  "genre_ids": [
                    14,
                    28,
                    80
                  ],
                  "id": 297761,
                  "original_title": "Suicide Squad",
                  "original_language": "en",
                  "title": "Suicide Squad",
                  "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
                  "popularity": 48.261451,
                  "vote_count": 1466,
                  "video": false,
                  "vote_average": 5.91
                }
              ],
              "total_results": 19629,
              "total_pages": 982
            }
        """.utf8)
    
    let genresData = Data("""
        {
          "genres": [
            {
              "id": 28,
              "name": "Action"
            },
            {
              "id": 14,
              "name": "Fantasy"
            },
          ]
        }
        """.utf8)
    
    // Setting up
    override func setUp() {
        
        movieRequestDTO = try! JSONDecoder().decode(MoviesRequestDTO.self,
                                                    from: movieRequestData)
        genresDTO = try! JSONDecoder().decode(GenresDTO.self, from: genresData)
    }
    
    override func tearDown() {
        movieRequestDTO = nil
        genresDTO = nil
    }
    
    /// Test if movie request encode is correct
    func testMovieRequestEncodeIsCorrect() {
        let movieRequest = MoviesRequestDTO(page: 1,
                                            movies: [
                                                MovieDTO(id: 297761,
                                                         title: "Suicide Squad",
                                                         releaseDate: "2016-08-03",
                                                         synopsis: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
                                                         posterPath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
                                                         genreIDS: [14, 28, 80])],
                                            totalResults: 19629,
                                            totalPages: 982)
        
        XCTAssertEqual(movieRequestDTO, movieRequest)
    }
    
    /// Test if genres encode is correct
    func testGenresEncodeIsCorrect() {
        let genres = GenresDTO(genres: [
            GenreDTO(id: 28, name: "Action"),
            GenreDTO(id: 14, name: "Fantasy")
        ])
        
        XCTAssertEqual(genresDTO, genres)
    }
}
