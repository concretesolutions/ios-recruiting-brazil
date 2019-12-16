//
//  NetworkServiceTests.swift
//  Challenge-ConcreteTests
//
//  Created by João Paulo de Oliveira Sabino on 16/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import XCTest
@testable import Challenge_Concrete
class NetworkServiceTests: XCTestCase {

    var apiProvider: APIProvider<Movie>!
    override func setUp() {
        apiProvider = APIProvider<Movie>()
        continueAfterFailure = false

    }

    override func tearDown() {
        apiProvider = nil
    }

    func testRequestTrendingMovies_success() {
        let expectation = XCTestExpectation(description: "Success on request")
        
        apiProvider.request(EndPoint.getTrending(mediaType: .movie, timeWindow: .day, page: 1)) { (result: Result<Response<Movie>, NetworkError>) in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("The request should be succeed")
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testRequestTrendingMovies_failure() {
        let expectation = XCTestExpectation(description: "Failure on request")
        
        apiProvider.request(EndPoint.getTrending(mediaType: .movie, timeWindow: .day, page: 999999999999)) { (result: Result<Response<Movie>, NetworkError>) in
            switch result {
            case .success:
                XCTFail("The request should fail")
            case .failure:
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testSearchMovies_notEmpty() {
        let expectation = XCTestExpectation(description: "Failure on request")
        
        apiProvider.request(EndPoint.searchMovie(query: "Avengers")) { (result: Result<Response<Movie>, NetworkError>) in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("The request should be succeed")
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testSearchMovies_empty() {
        let expectation = XCTestExpectation(description: "Success on request")
        
        apiProvider.request(EndPoint.searchMovie(query: "This request query should not return a movie")) { (result: Result<Response<Movie>, NetworkError>) in
            switch result {
            case .success(let response):
                expectation.fulfill()
                XCTAssertEqual(response.results.count, 0)
            case .failure:
                XCTFail("The request should be succeed")
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testRequestImage_success() {
        let expectation = XCTestExpectation(description: "Success on request")
        let imgPath = "/jyw8VKYEiM1UDzPB7NsisUgBeJ8.jpg"
        apiProvider.request(EndPoint.getImage(path: imgPath)) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("The request should be succeed")
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testRequestImage_failure() {
        let expectation = XCTestExpectation(description: "Failure on request")
        let wrongImgPath = "wrongPath"
        apiProvider.request(EndPoint.getImage(path: wrongImgPath)) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                expectation.fulfill()
                XCTAssertNil(UIImage(data: data))
            case .failure:
                break
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
