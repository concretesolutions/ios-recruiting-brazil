//
//  NetworkError.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

// A Enum for the app network errors.
public enum NetworkError: Error, CustomStringConvertible {
    public var description: String {
        switch self {
        case .wrongURL(let wrongRoute):
            return "The request route is wrong: \(wrongRoute)"
        case .noResponseData, .noHttpResponse:
            return "The request response is in a wrong format"
        case .httpError(let errorCode):
            return "The request ended with a HTTP Error of code: \(errorCode)"
        }
    }
    
    case wrongURL(Route), noResponseData, noHttpResponse, httpError(Int)
}
