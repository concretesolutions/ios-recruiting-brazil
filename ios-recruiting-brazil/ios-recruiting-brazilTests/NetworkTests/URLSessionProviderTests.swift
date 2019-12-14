//
//  URLSessionProviderTests.swift
//  ios-recruiting-brazilTests
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import XCTest
@testable import ios_recruiting_brazil

class URLSessionProviderTests: XCTestCase {

    var session = MockURLSession()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        let provider = URLSessionProvider(session: session)
        let service = MockService.get
        provider.request(type: MockModel.self, service: service) { (result) in
            return
        }
        XCTAssert(dataTask.resumeWasCalled)
        
    }
    
    func testGetResultSuccess() {
        let dataTask = MockURLSessionDataTask()
        let expectation = XCTestExpectation(description: "Esperando resultado")
        session.nextDataTask = dataTask
        let provider = URLSessionProvider(session: session)
        let service = MockService.get
        provider.request(type: MockModel.self, service: service) { (result) in
            print("\n\n\(dataTask.resumeWasCalled)\n\n")
            switch result {
            case .failure(let error):
                print(error)
            case .success(let model):
                print(model)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetResultWrongModel() {
        let dataTask = MockURLSessionDataTask()
            let expectation = XCTestExpectation(description: "Esperando resultado")
            session.nextDataTask = dataTask
            let provider = URLSessionProvider(session: session)
            let service = MockService.get
            provider.request(type: MockWrongModel.self, service: service) { (result) in
                print("\n\n\(dataTask.resumeWasCalled)\n\n")
                switch result {
                case .failure(let error):
                    print(error)
                    expectation.fulfill()
                case .success(let model):
                    print(model)
                }
            }
            
            wait(for: [expectation], timeout: 10)
    }
    
    func testReceivedFailedHTTPResponse() {
        let dataTask = MockURLSessionDataTask()
            let expectation = XCTestExpectation(description: "Esperando resultado")
            session.nextDataTask = dataTask
            let provider = URLSessionProvider(session: session)
            let service = MockService.get
            session.response = session.createResponse(statusCode: 400)
            provider.request(type: MockModel.self, service: service) { (result) in
                print("\n\n\(dataTask.resumeWasCalled)\n\n")
                switch result {
                case .failure(let error):
                    print(error)
                    expectation.fulfill()
                case .success(let model):
                    print(model)
                }
            }
            
            wait(for: [expectation], timeout: 10)
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
