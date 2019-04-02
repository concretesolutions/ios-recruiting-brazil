//
//  MovsTests.swift
//  MovsTests
//
//  Created by Alexandre Papanis on 01/04/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import XCTest
import Alamofire
@testable import Movs

class MovsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchMovies() {
        
        let promise = expectation(description: "get popular movies by page")
        let page = 1
        APIClient.getPopularMovies(page: page) { result in
            switch result {
            case .success(let movies):
                XCTAssert(movies.count > 0, "Repositorios - OK")
                promise.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetCoverPath() {
        
        let promise = expectation(description: "get closed issues of repository")

        let url = "/xvx4Yhf0DVH8G4LzNISpMfFBDy2.jpg"
        
        let name = url.replacingOccurrences(of: "/", with: "_")
        
        var filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        filePath = filePath.appendingPathComponent(name)
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            XCTAssert(true, "File exists at FilePath")
            promise.fulfill()
        } else {
            APIClient.dataFrom(url: url) { result in
                switch result {
                case .success(let data):
                    do {
                        try data.write(to: filePath, options: .atomic)
                        XCTAssert(true, "Cover written to FilePath")
                        promise.fulfill()
                    } catch {
                        print("Unable to write data: \(error)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    XCTFail()
                }
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
