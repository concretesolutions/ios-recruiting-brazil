//
//  SearchBarResultsSpec.swift
//  DesafioConcreteTests
//
//  Created by Gustavo Garcia Leite on 07/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import XCTest
@testable import DesafioConcrete

class SearchBarResultsSpec: XCTestCase {

    func testFilter() {
        let movies: [Movie] = [Movie(popularity: 0.0, voteCount: 1, video: false, posterPath: "", id: 2222, adult: false, backdropPath: "", originalLanguage: "", originalTitle: "", genreIds: [1], title: "Frozen II", voteAverage: 1.0, overview: "", releaseDate: ""), Movie(popularity: 0.0, voteCount: 1, video: false, posterPath: "", id: 2222, adult: false, backdropPath: "", originalLanguage: "", originalTitle: "", genreIds: [1], title: "Frozen II", voteAverage: 1.0, overview: "", releaseDate: "Fast & Furious"), Movie(popularity: 0.0, voteCount: 1, video: false, posterPath: "", id: 2222, adult: false, backdropPath: "", originalLanguage: "", originalTitle: "", genreIds: [1], title: "Terminator", voteAverage: 1.0, overview: "", releaseDate: "")]
        var filteredMovies: [Movie] = []
        
        let text = "f"
        
        filteredMovies = movies.filter { (movie: Movie) -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        }
        
        XCTAssert(filteredMovies[1].title == "Frozen II")
    }
}
