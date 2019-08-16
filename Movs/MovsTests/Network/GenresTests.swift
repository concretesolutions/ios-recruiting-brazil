//
//  GenresTests.swift
//  MovsTests
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

@testable import Movs
import XCTest

class GenresTests: BaseNetworkTest {

    func testFetchGenres() {
        let movieService = DependencyResolver.shared.resolve(MovieService.self)
        let fetchGenresExpectation = expectation(description: "genres-expectation")
        let apiKey = MovieApiConfig.privateKey
        let endPoint = "\(MovieApiConfig.EndPoint.genres)?api_key=\(apiKey)&language=en"
        createStub(withFileName: "Genres200", statusCode: 200, path: endPoint)
        movieService.getGenres { result in
            switch result {
            case .success(let genres):
                XCTAssertEqual(genres.count, 19)

                let genre = genres.first
                XCTAssertNotNil(genre)
                XCTAssertEqual(genre?.id, 28)
                XCTAssertEqual(genre?.name, "Action")

                fetchGenresExpectation.fulfill()
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
