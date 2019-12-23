//
//  DataTransferObjectsTests.swift
//  movsTests
//
//  Created by Emerson Victor on 03/12/19.
//  Copyright © 2019 emer. All rights reserved.
//
// swiftlint:disable line_length force_try
import XCTest
@testable import Movs

class DataTransferObjectsTests: XCTestCase {
    
    var movieRequestDTO: MoviesRequestDTO!
    var genresDTO: GenresDTO!
    var movieDetailDTO: MovieDetailDTO!
    
    override func setUp() {
        super.setUp()
        self.movieRequestDTO = nil
        self.genresDTO = nil
        self.movieDetailDTO = nil
    }
    
    func testMovieRequestEncodeIsCorrect() {
        self.movieRequestDTO = try! JSONDecoder().decode(MoviesRequestDTO.self,
                                                         from: DataTransferObjectsMock.movieRequestData)
        let movieRequest = MoviesRequestDTO(page: 1,
                                            movies: [
                                                MovieDTO(id: 297761,
                                                         title: "Suicide Squad",
                                                         releaseDate: "2016-08-03",
                                                         synopsis: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
                                                         posterPath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
                                                         genreIDs: [14, 28, 80])],
                                            totalResults: 19629,
                                            totalPages: 982)
        
        XCTAssertEqual(self.movieRequestDTO, movieRequest)
    }
    
    func testGenresEncodeIsCorrect() {
        self.genresDTO = try! JSONDecoder().decode(GenresDTO.self,
                                                   from: DataTransferObjectsMock.genresData)
        let genres = GenresDTO(genres: [
            GenreDTO(id: 28, name: "Action"),
            GenreDTO(id: 14, name: "Fantasy")
        ])
        
        XCTAssertEqual(self.genresDTO, genres)
    }
    
    func testMovieDetailEncodeIsCorrect() {
        self.movieDetailDTO = try! JSONDecoder().decode(MovieDetailDTO.self,
                                                        from: DataTransferObjectsMock.movieDetailData)
        let movieDetail = MovieDetailDTO(id: 550,
                                         title: "Fight Club",
                                         releaseDate: "1999-10-12",
                                         synopsis: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground fight clubs forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
                                         posterPath: nil,
                                         genres: [GenreDTO(id: 24, name: "Action")])

        XCTAssertEqual(self.movieDetailDTO, movieDetail)
    }
}
