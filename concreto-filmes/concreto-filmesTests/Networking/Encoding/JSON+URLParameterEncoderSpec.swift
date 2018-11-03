//
//  JSONParameterEncoderSpec.swift
//  concreto-filmesTests
//
//  Created by Leonel Menezes on 03/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import concreto_filmes

class JSONParameterEncoderSpec: QuickSpec {
    override func spec() {
        describe("Encode parameters into request") {
            var urlRequest: URLRequest!
            var parameters: Parameters!
            
            beforeEach {
                parameters = [
                    "age": 25,
                    "name": "Leonel"
                ]
                urlRequest = URLRequest(url: URL(string: "www.test.com")!)
            }
            
            it("Should encode parameters into request body", closure: {
                do {
                    try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: parameters)
                    expect(urlRequest.httpBody).toNot(beNil())
                } catch {
                    fail("failed to encode JSON to request")
                }
            })
            
            it("should encode parameters into request url", closure: {
                do {
                    try URLParameterEncoder.encode(urlRequest: &urlRequest, with: parameters)
                    if let urlString = urlRequest.url?.absoluteString {
                        expect(urlString).to(contain(["name=Leonel", "age=25"]))
                    } else {
                        fail("Could not retrieve string from url")
                    }
                } catch {
                    fail(error.localizedDescription)
                }
            })
            
        }
    }
}
