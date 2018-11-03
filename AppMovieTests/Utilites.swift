//
//  Utilites.swift
//  AppMovieTests
//
//  Created by Renan Alves on 02/11/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import XCTest
@testable import AppMovie

class Utilites: XCTestCase {
    
    func testeConverteDate() {
        let stringAssertTrue = "1998-05-28"
//        let StringAssetFalse = "28-05-1998"
        
        if Date.convertDateFormatter(stringDate: stringAssertTrue) != nil {
            XCTAssertTrue(true)
        }else {
            XCTFail("Nothing return Date")
        }
    }

    func testeGetComponentCalendar() {
        let stringDate = "1998-05-28"
        
        if let date = Date.convertDateFormatter(stringDate: stringDate) {
            let component = Date.getComponent(from: .year, at: date)
            if component is Int {
                XCTAssertTrue(true)
            }else {
                XCTFail("Could not get component calendar")
            }
        }
    }
}
