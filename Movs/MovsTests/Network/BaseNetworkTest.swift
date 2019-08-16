//
//  BaseNetworkTest.swift
//  MovsTests
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

@testable import Movs
import OHHTTPStubs
import Swinject
import XCTest

class BaseNetworkTest: XCTestCase {

    override func setUp() {
        DependencyInjector.registerDependencies()
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
    }
}
