//
//  APITest.swift
//  XPInvestimentoTests
//
//  Created by Kaique Magno Dos Santos on 22/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import XCTest
@testable import Concrete

class APITest: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPopularMoviesRequest() {
        let waiter = XCTWaiter(delegate: self)
        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
        
        let request = GetPopularMovies()
        
        APIManager.shared.fetch(request) { (response) in
            switch response {
            case .success(let dataContainer):
                XCTAssert(dataContainer.totalResults > 0)
                answerAPIExpectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
                answerAPIExpectation.fulfill()
                print(error.localizedDescription)
            }
        }
        
        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
    }
    
    func testGetSearchMoviesRequest() {
        let waiter = XCTWaiter(delegate: self)
        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
        
        let request = GetSearchMovies(query: "Avenger")
        
        APIManager.shared.fetch(request) { (response) in
            switch response {
            case .success(let dataContainer):
                XCTAssert(dataContainer.totalResults == 124)
                answerAPIExpectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
                answerAPIExpectation.fulfill()
                print(error.localizedDescription)
            }
        }
        
        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
    }
    
    
    func testGetImageMovieRequest() {
        let waiter = XCTWaiter(delegate: self)
        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
        
        let request = GetImageMovie(movieId: 332467)
        
        APIManager.shared.fetch(request) { (response) in
            switch response {
            case .success(let dataContainer):
                XCTAssert(dataContainer.backdrops.count > 0 || dataContainer.posters.count > 0)
                answerAPIExpectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
                answerAPIExpectation.fulfill()
                print(error.localizedDescription)
            }
        }
        
        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
    }

    func testGetGenresRequest() {
        let waiter = XCTWaiter(delegate: self)
        let answerAPIExpectation = XCTestExpectation(description: "AnswerAPI")
        
        let request = GetGenres()
        
        APIManager.shared.fetch(request) { (response) in
            switch response {
            case .success(let dataContainer):
                //TODO: Verify list of total results on the API.
                XCTAssert(dataContainer.genres.count > 0)
                answerAPIExpectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
                answerAPIExpectation.fulfill()
                print(error.localizedDescription)
            }
        }
        
        waiter.wait(for: [answerAPIExpectation], timeout: 20.0, enforceOrder: true)
    }

    
    
    
    // MARK: - XCTWaiterDelegate
    override func waiter(_ waiter: XCTWaiter, didFulfillInvertedExpectation expectation: XCTestExpectation) {
        
    }
    override func waiter(_ waiter: XCTWaiter, didTimeoutWithUnfulfilledExpectations unfulfilledExpectations: [XCTestExpectation]) {
        XCTFail("Did not fulfil expectations")
    }
}

