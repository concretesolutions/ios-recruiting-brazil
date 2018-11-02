//
//  FetchMoviesOperationTests.swift
//  MovsTests
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import XCTest
@testable import Movs

class FetchMoviesOperationTests: XCTestCase {
    
    let operation = FetchMoviesOperation()
    
    func testFetchMoviesOperationShouldReturnMovies() {
        let exp = self.expectation(description: "success")
        
        operation.onSuccess = { _ in
            exp.fulfill()
        }
        
        operation.perform()
        
        self.wait(for: [exp], timeout: 2.0)
    }
}
