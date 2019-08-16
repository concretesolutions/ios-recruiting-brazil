//
//  XCTestCase+Movs.swift
//  MovsTests
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

@testable import Movs
import OHHTTPStubs
import Swinject
import XCTest

extension XCTestCase {

    func createStub(withFileName fileName: String, statusCode: Int32, path: String) {

        guard let stubPath = OHPathForFile("\(fileName).json", type(of: self)) else {
            return XCTFail("stubPath should be not nil")
        }
        stub(condition: isPath(path)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: stubPath,
                statusCode: statusCode,
                headers: ["Content-Type": "application/json"]
            )
        }.name = "\(fileName) - \(path)"
    }
}
