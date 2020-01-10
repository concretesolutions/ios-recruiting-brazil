//
//  NetworkManagerErrorSpec.swift
//  NetworkLayerTests
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Quick
import Nimble

@testable import NetworkLayer

class NetworkManagerErrorSpec: QuickSpec {

    var session: NetworkSessionMock!
    var networkManager: NetworkManager!

    override func spec() {
        beforeEach {
            self.session = NetworkSessionMock()
            self.networkManager = NetworkManager(session: self.session)
        }

        describe("Network Manager request") {

            it("should return error on invalid url") {
                var error: Error?
                var networkManager = NetworkManager(session: self.session)

                networkManager.request(NetworkServiceInvalidURLMock.invalidURL) { (result: Result<UserMock, Error>) in
                    guard case let .failure(err) = result else {
                        return fail("Expecting failure, got success")
                    }
                    error = err
                }
                expect(error?.localizedDescription).to(equal(
                    NetworkError.invalidURL.localizedDescription))
            }

            it("should return error on empty data") {
                var error: Error?

                self.networkManager.request(NetworkServiceMock.success) { (result: Result<UserMock, Error>) in
                    guard case let .failure(err) = result else {
                        return fail("Expecting failure, got success")
                    }
                    error = err
                }

                expect(error?.localizedDescription).to(equal(
                    NetworkError.emptyData.localizedDescription))
            }

            it("should return error on empty response") {
                var error: Error?

                self.session.response = nil
                self.networkManager.session = self.session

                self.networkManager.request(NetworkServiceMock.success) { (result: Result<UserMock, Error>) in
                    guard case let .failure(err) = result else {
                        return fail("Expecting failure, got success")
                    }
                    error = err
                }

                expect(error?.localizedDescription).to(equal(
                    NetworkError.emptyResponse.localizedDescription))
            }

            it("should return error on network error") {
                var error: Error?

                self.session.error = TestConstants.mockError()
                self.networkManager.session = self.session

                self.networkManager.request(NetworkServiceMock.error) { (result: Result<UserMock, Error>) in
                    guard case let .failure(err) = result else {
                        return fail("Expecting failure, got success")
                    }
                    error = err
                }
                expect(error?.localizedDescription.starts(with: "Request error:")).to(beTrue())
            }
        }
    }
}
