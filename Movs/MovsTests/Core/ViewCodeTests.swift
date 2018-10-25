//
//  ViewCodeTests.swift
//  MovsTests
//
//  Created by Gabriel Reynoso on 25/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import XCTest
@testable import Movs

class ViewCodeTests: XCTestCase {
    
    private var designWasCalled:Bool = false
    private var autolayoutWasCalled:Bool = false
    private var additionalSetupsWasCalled:Bool = false
    
    func testSetupShouldCallAllViewCodeMethods() {
        self.setup()
        XCTAssertTrue(self.designWasCalled && self.autolayoutWasCalled && self.additionalSetupsWasCalled)
    }
}

extension ViewCodeTests: ViewCode {
    
    func design() {
        self.designWasCalled = true
    }
    
    func autolayout() {
        self.autolayoutWasCalled = true
    }
    
    func additionalSetups() {
        self.additionalSetupsWasCalled = true
    }
}
