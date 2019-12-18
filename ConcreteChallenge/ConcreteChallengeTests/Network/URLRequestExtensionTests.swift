//
//  URLRequestExtensionTests.swift
//  ConcreteChallengeTests
//
//  Created by Matheus Oliveira Costa on 18/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import XCTest
@testable import Movs

class URLRequestExtensionTests: XCTestCase {

    func test_initWithService_headerFields() {
        let service = ServiceMock.requestWithHeaders
        let expectedHeaders = ["test-key": "test-value"]
        let request = URLRequest(service: service)
        XCTAssertEqual(request?.allHTTPHeaderFields, expectedHeaders)
    }

    func test_initWithService_httpBady() {
        let model = ModelMock(name: "Matheus")
        let service = ServiceMock.requestWithBody(model)
        let request = URLRequest(service: service)
        XCTAssertEqual(request?.httpBody, model.encoded())
    }

}
