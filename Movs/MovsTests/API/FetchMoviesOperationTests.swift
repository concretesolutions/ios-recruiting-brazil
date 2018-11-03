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
    
    func testFetchMoviesOperationShouldChangePage() {
        
        XCTAssertTrue(self.operation.page == 1)
        let exp = self.expectation(description: "success")
        
        self.operation.onSuccess = { _ in
            exp.fulfill()
        }
        
        self.operation.performFromNextPage()
        XCTAssertTrue(self.operation.page == 2)
        
        self.wait(for: [exp], timeout: 2.0)
    }
    
    func testUnrwapJsonResultShouldUnrwapDictionary() {
        let jsonData = "{\"results\":{}}".data(using: .utf8)!
        XCTAssertNotNil(self.operation.unrwapResultsJSON(from: jsonData))
    }
    
    func testUnrwapJsonResultShouldReturnNil() {
        let jsonData = "".data(using: .utf8)!
        XCTAssertNil(self.operation.unrwapResultsJSON(from: jsonData))
    }
}
