//
//  LocalMockProviderSpecs.swift
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

class URLSessionFileProviderSpecs: QuickSpec {
    override func spec() {
        var urlSessionFileProvider: URLSessionFileProvider!
        beforeEach {
            urlSessionFileProvider = URLSessionFileProvider()
        }
           
        describe("app is requesting some files data") {
            context("request has returned some error") {
                it("must send the same request") {
                    var returnedError: Error?
                    stub(condition: { _ in return true }) { (request) -> OHHTTPStubsResponse in
                        return .init(error: MockError())
                    }

                    urlSessionFileProvider.request(route: BasicRoute(url: URL(string: "https://www.mock.com")!)) { (result) in
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
        }
        
        context("a wrong route was provided") {
            it("must throw a error") {
                var returnError: NetworkError?
                stub(condition: { _ in return true }) { (request) -> OHHTTPStubsResponse in
                    return .init(data: Data(), statusCode: 200, headers: nil)
                }

                let wrongRoute = MockRoute(baseURL: URL(string: "https://www.mock.com")!, path: "www.#@", method: .get, urlParams: [])
                urlSessionFileProvider.request(route: wrongRoute) { (result) in
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
        
        context("urlsession provided some file url") {
            it("must return this url") {
                var returnURL: URL?
                stub(condition: { _ in return true }) { (request) -> OHHTTPStubsResponse in
                    let mockImageURL = Bundle(for: URLSessionParserProviderSpecs.self)
                                             .url(forResource: "mockImage", withExtension: ".png")!
                    return .init(fileURL: mockImageURL, statusCode: 200, headers: nil)
                }

                urlSessionFileProvider.request(route: BasicRoute(url: URL(string: "https://www.mock.com")!)) { (result) in
                    switch result {
                    case .failure:
                        returnURL = nil
                    case .success(let url):
                        returnURL = url
                    }
                }
                
                expect(returnURL).toEventuallyNot(beNil())
            }
        }
    }
}
