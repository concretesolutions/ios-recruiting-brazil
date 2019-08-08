//
//  StringExtensionTests.swift
//  SearchMoviesTests
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import XCTest
@testable import SearchMovies

class StringExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeBase64String() {
        let strBase64:String = "dmlhbmEubGVvbmFyZG8uQmx1ZW1lcmFuZy1Db2xvcg=="
        let strBaseDecode:String? = strBase64.fromBase64()
        XCTAssertTrue(strBaseDecode != nil)
    }
    
    func testEncodeBase64String() {
        // let str:String = "viana.leonardo.Bluemerang-Color"
        //https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
        let str:String = "http://image.tmdb.org/t/p/w185/"
        let strBaseEncode:String? = str.toBase64()
        XCTAssertTrue(strBaseEncode != nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
