//
//  URLSessionParserProviderSpecs.swift
//  GenericNetworkTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import GenericNetwork

class URLSessionParserProviderSpecs: QuickSpec {
    override func spec() {
        var urlSessionProvider: URLSessionParserProvider<JSONParser<MockModel>>!
        beforeEach {
            urlSessionProvider = URLSessionJSONParserProvider<MockModel>()
        }
           
        describe("app is requesting some data") {
            context("urls session returned a error") {
                it("must return a error too") {
                    var returnedError: Error?
                    stub(condition: { _ in return true }) { (request) -> OHHTTPStubsResponse in
                        return .init(error: MockError())
                    }

                    urlSessionProvider.requestAndParse(route: BasicRoute(url: URL(string: "https://www.mock.com")!)) { (result) in
                        switch result {
                        case .success:
                            returnedError = nil
                        case .failure(let error):
                            returnedError = error
                        }
                    }
                    
                    expect(returnedError).toEventuallyNot(beNil())
                }
            }
            
            context("urlsession provided some data") {
                it("must return this data") {
                    var returnData: Data?
                    stub(condition: { _ in return true }) { (request) -> OHHTTPStubsResponse in
                        return .init(data: Data(), statusCode: 200, headers: nil)
                    }

                    urlSessionProvider.request(route: BasicRoute(url: URL(string: "https://www.mock.com")!)) { (result) in
                        switch result {
                        case .failure:
                            returnData = nil
                        case .success(let data):
                            returnData = data
                        }
                    }
                    
                    expect(returnData).toEventuallyNot(beNil())
                }
            }
            
            context("a http error code was given in response") {
                it("must throw a error") {
                    var returnError: NetworkError?
                    stub(condition: { _ in return true }) { (request) -> OHHTTPStubsResponse in
                        return .init(data: Data(), statusCode: 403, headers: nil)
                    }

                    urlSessionProvider.request(route: BasicRoute(url: URL(string: "https://www.mock.com")!)) { (result) in
                        switch result {
                        case .failure(let error):
                            switch error {
                            case NetworkError.httpError(403):
                                returnError = error as? NetworkError
                            default:
                                returnError = nil
                            }
                        case .success:
                            returnError = nil
                        }
                    }
                    
                    expect(returnError).toEventuallyNot(beNil())
                }
            }
            
            context("a wrong route was provided") {
                it("must throw a error") {
                    var returnError: NetworkError?
                    stub(condition: { _ in return true }) { (request) -> OHHTTPStubsResponse in
                        return .init(data: Data(), statusCode: 200, headers: nil)
                    }

                    let wrongRoute = MockRoute(baseURL: URL(string: "https://www.mock.com")!, path: "www.#@", method: .get, urlParams: [])
                    urlSessionProvider.request(route: wrongRoute) { (result) in
                        switch result {
                        case .failure(let error):
                            switch error {
                            case NetworkError.wrongURL:
                                returnError = error as? NetworkError
                            default:
                                returnError = nil
                            }
                        case .success:
                            returnError = nil
                        }
                    }
                    
                    expect(returnError).toEventuallyNot(beNil())
                }
            }
        }
    }
}
