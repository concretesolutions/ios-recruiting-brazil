//
//  Test_MovieDBTests.swift
//  Test-MovieDBTests
//
//  Created by Gabriel Soria Souza on 16/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import XCTest
@testable import Test_MovieDB

class Test_MovieDBTests: XCTestCase {
    
    let popular = PopularMoviesViewController()
    var popularMiddle: PopularMoviesMiddle!
    
    override func setUp() {
        popularMiddle = PopularMoviesMiddle(delegate: popularMiddle as! PopularMoviesMiddleDelegate)
    }

    func test_testFetch() {
        
    }
}
