//
//  MoviesTests.swift
//  MovsTests
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

@testable import Movs
import XCTest

class MoviesTests: BaseNetworkTest {

    func testFetchMovies() {
        let movieService = DependencyResolver.shared.resolve(MovieService.self)
        let fetchMoviesExpectation = expectation(description: "movies-expectation")
        let moviePage = 1
        let apiKey = MovieApiConfig.privateKey
        let endPoint = "\(MovieApiConfig.EndPoint.popular)?page=\(moviePage)&api_key=\(apiKey)&language=en"
        createStub(withFileName: "Movies200", statusCode: 200, path: endPoint)
        movieService.getPopularMovies(page: moviePage) { result in
            switch result {
            case .success(let movies):
                XCTAssertEqual(movies.count, 20)

                let movie = movies.first
                XCTAssertNotNil(movie)
                XCTAssertEqual(movie?.id, 384018)
                XCTAssertEqual(movie?.title, "Fast & Furious Presents: Hobbs & Shaw")
                XCTAssertEqual(movie?.posterPath, "/keym7MPn1icW1wWfzMnW3HeuzWU.jpg")
                XCTAssertEqual(movie?.overview, "A spinoff of The Fate of the Furious, focusing on Johnson\'s US Diplomatic Security Agent Luke Hobbs forming an unlikely alliance with Statham\'s Deckard Shaw.")
                XCTAssertEqual(movie?.releaseYear, "2019")
                XCTAssertEqual(movie?.isFavorite, false)

                fetchMoviesExpectation.fulfill()
            case .error(let error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 5) { error in
            if let error = error {
                return XCTFail(error.localizedDescription)
            }
        }
    }
}
