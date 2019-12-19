//
//  NetworkManagerResponseErrorSpec.swift
//  NetworkLayerTests
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Quick
import Nimble

@testable import NetworkLayer

class NetworkManagerResponseErrorSpec: QuickSpec {

    var session: NetworkSessionMock!
    var networkManager: NetworkManager<NetworkServiceMock>!

    override func spec() {
        beforeEach {
            self.session = NetworkSessionMock()
            self.networkManager = NetworkManager(session: self.session)
        }

        describe("Network Manager request") {

            it("should return error when cant decode model") {
                var error: Error?

                let expectedUser = [
                    "uuid": Int(TestConstants.userUUIDExample.rawValue)!,
                    "nameWRONG": TestConstants.userNameExample.rawValue
                    ] as [String: Any]

                self.session.data = try? JSONSerialization.data(withJSONObject: expectedUser, options: [])
                self.networkManager.session = self.session

                self.networkManager.request(.decodeError) { (result: Result<UserMock, Error>) in
                    guard case let .failure(err) = result else {
                        return fail("Expecting failure, got success")
                    }
                    error = err
                }
                expect(error?.localizedDescription.starts(with: "Decoding error:")).to(beTrue())
            }

            it("should return error on redirecting server response") {
                self.mockError(statusCode: 301)
                self.testError(endpoint: .redirectingError, expectedError: .redirectingError(nil))
            }

            it("should return error when server responds with client error") {
                self.mockError(statusCode: 401)
                self.testError(endpoint: .clientError, expectedError: .clientError(nil))
            }

            it("should return error when server responds with server error") {
                self.mockError(statusCode: 500)
                self.testError(endpoint: .serverError, expectedError: .serverError(nil))
            }

            it("should return error when server responds with unknown error") {
                self.mockError(statusCode: 0)
                self.testError(endpoint: .unknownError, expectedError: .unknown)
            }
        }
    }

    func mockError(statusCode: Int) {
        self.session.data = Data()
        self.session.response = NetworkSessionMock.mockResponse(statusCode: statusCode)
        self.networkManager.session = self.session
    }

    func testError(endpoint: NetworkServiceMock, expectedError: NetworkError) {
        var error: Error?

        self.networkManager.request(endpoint) { (result: Result<UserMock, Error>) in
            guard case let .failure(err) = result else {
                return fail("Expecting failure, got success")
            }
            error = err
        }
        expect(error?.localizedDescription).to(equal(expectedError.localizedDescription))
    }
}
