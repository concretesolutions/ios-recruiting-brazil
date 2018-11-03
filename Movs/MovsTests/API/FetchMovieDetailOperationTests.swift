//
//  FetchMovieDetailOperationTests.swift
//  MovsTests
//
//  Created by Gabriel Reynoso on 03/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import XCTest
@testable import Movs

class FetchMovieDetailOperationTests: XCTestCase {

    private var operation: FetchMovieDetailOperation!
    
    func testFetchMovieDetailOperationShouldReturnMovieDetail() {
        self.operation = FetchMovieDetailOperation(movieId: 157336)
        let exp = self.expectation(description: "success")
        
        self.operation.onSuccess = { _ in
            exp.fulfill()
        }
        
        self.operation.perform()
        self.wait(for: [exp], timeout: 2.0)
    }

    func testFetchMovieDetailOperationShouldReturnNotFound() {
        self.operation = FetchMovieDetailOperation(movieId: -1)
        let exp = self.expectation(description: "success")
        
        self.operation.onError = { err in
            guard let error = err as? APIError else { return }
            if error == .notFound {
                exp.fulfill()
            }
        }
        
        self.operation.perform()
        self.wait(for: [exp], timeout: 2.0)
    }
}
