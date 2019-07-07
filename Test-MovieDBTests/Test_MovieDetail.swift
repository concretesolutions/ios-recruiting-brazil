//
//  Test_MovieDetail.swift
//  Test-MovieDBTests
//
//  Created by Gabriel Soria Souza on 12/12/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import XCTest
@testable import Test_MovieDB

class Test_MovieDetail: XCTestCase {

    let detailVC = MovieDetailViewController()
    var detailMiddle: MovieDetailMiddle!
    
    
    override func setUp() {
        detailMiddle = MovieDetailMiddle(delegate: detailVC as MovieDetailMiddleDelegate)
        detailVC.middle = detailMiddle
    }

    override func tearDown() {
        
    }


    

}
