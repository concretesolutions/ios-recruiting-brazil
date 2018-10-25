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
    private var setupCount:Int = 0
    
    var settedUp:Bool = false
    
    override func setUp() {
        self.designWasCalled = false
        self.autolayoutWasCalled = false
        self.additionalSetupsWasCalled = false
        self.setupCount = 0
        self.settedUp = false
    }
    
    private var allMethodsWereCalled:Bool {
        return self.designWasCalled && self.autolayoutWasCalled && self.additionalSetupsWasCalled
    }
    
    func testSetupViewShouldCallAllViewCodeMethods() {
        self.setupView()
        XCTAssertTrue(self.allMethodsWereCalled)
    }
    
    func testSetupViewShouldChangeSettedUpValue() {
        self.setupView()
        XCTAssertTrue(self.settedUp)
    }
    
    func testReusableViewCodeShouldNotSetupTwice() {
        self.setupView()
        self.setupView()
        XCTAssertTrue(self.setupCount == 1)
    }
}

extension ViewCodeTests: ReusableViewCode {
    
    func design() {
        self.designWasCalled = true
        self.setupCount += 1
    }
    
    func autolayout() {
        self.autolayoutWasCalled = true
    }
    
    func additionalSetups() {
        self.additionalSetupsWasCalled = true
    }
}
