//
//  TestConstants.swift
//  NetworkLayerTests
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Foundation

enum TestConstants: String {
    case host = "https://testHost"
    case invalidHost = "https://testHost:-80"

    case userUUIDExample = "1"
    case userNameExample = "test"

    enum Path: String {
        case success = "/success"
        case decodeError = "/decodeError"
        case redirectingError = "/redirectingError"
        case clientError = "/clientError"
        case serverError = "/serverError"
        case unknownError = "/unknownError"
        case error = "/error"
        case post = "/post"
    }

    static func mockError() -> NSError {
        return NSError(domain: "Error", code: 1, userInfo: nil)
    }

    static func mockURL() -> URL {
        return URL(fileURLWithPath: "")
    }
}
