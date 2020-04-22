//
//  XCTestCase+Extension.swift
//  Movies-BrowserUITests
//
//  Created by Gustavo Severo on 21/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import XCTest

extension XCTestCase {
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        waitForExpectations(timeout: duration + 0.5)
    }
}
