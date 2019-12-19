//
//  URLSessionProviderTests.swift
//  ConcreteChallengeTests
//
//  Created by Matheus Oliveira Costa on 18/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import XCTest
@testable import Movs

class URLSessionProviderTests: XCTestCase {

    func test_request_withDecodableSuccess() {
        let mockSession = URLSessionMockSuccess(modelData: simpleModelResponse())
        let provider = URLSessionProvider(session: mockSession)
        let basicRequest = ServiceMock.basicRequest
        let expectation = XCTestExpectation(description: "Esperando \(#function)")
        provider.request(type: ModelMock.self, service: basicRequest) { (result) in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("Test case \(#function) falhou")
            }
        }

        wait(for: [expectation], timeout: 10)
    }

    func test_request_withDecodableError() {
        let mockSession = URLSessionMockError()
        let provider = URLSessionProvider(session: mockSession)
        let basicRequest = ServiceMock.basicRequest
        let expectation = XCTestExpectation(description: "Esperando \(#function)")
        provider.request(type: ModelMock.self, service: basicRequest) { (result) in
            switch result {
            case .success:
                XCTFail("Test case \(#function) teve sucesso")
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 10)
    }

    func test_request_withSuccess() {
        let mockSession = URLSessionMockSuccess(modelData: simpleModelResponse())
        let provider = URLSessionProvider(session: mockSession)
        let basicRequest = ServiceMock.basicRequest
        let expectation = XCTestExpectation(description: "Esperando \(#function)")
        provider.request(service: basicRequest) { (result) in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("Test case \(#function) falhou")
            }
        }

        wait(for: [expectation], timeout: 10)
    }

    func test_request_withError() {
        let mockSession = URLSessionMockError()
        let provider = URLSessionProvider(session: mockSession)
        let basicRequest = ServiceMock.basicRequest
        let expectation = XCTestExpectation(description: "Esperando \(#function)")
        provider.request(service: basicRequest) { (result) in
            switch result {
            case .success:
                XCTFail("Test case \(#function) teve sucesso")
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 10)
    }

    func test_request_withDecodablePopularMovies() {
        let mockSession = URLSessionMockSuccess(modelData: popularMoviesResponse())
        let provider = URLSessionProvider(session: mockSession)
        let popularMovies = MovieDBService.popularMovies(1)
        let expectation = XCTestExpectation(description: "Esperando \(#function)")
        provider.request(type: PopularMoviesRoot.self, service: popularMovies) { (result) in
            switch result {
            case .success(let root):
                XCTAssertEqual(root.page, 1)
                XCTAssertNotNil(root.results)
                XCTAssertEqual(root.results.first?.title, "Ad Astra")
                expectation.fulfill()
            case .failure:
                XCTFail("Test case \(#function) falhou")
            }
        }

        wait(for: [expectation], timeout: 10)
    }

}
