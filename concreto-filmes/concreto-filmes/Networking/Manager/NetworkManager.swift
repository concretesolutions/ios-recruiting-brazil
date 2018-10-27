//
//  NetworkManager.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

class NetworkManager<T: EndPointType> {
    internal let router = Router<T>()

    internal func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return Result.failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return Result.failure(NetworkResponse.badRequest.rawValue)
        case 600: return Result.failure(NetworkResponse.outdate.rawValue)
        case 1003: return Result.failure(NetworkResponse.requestLimitReached.rawValue)
        default:
            return Result.failure(NetworkResponse.failed.rawValue)
        }
    }
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingURL = "URL is nil"
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdate = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case requestLimitReached = "Please try again later..."
}

enum Result<String> {
    case success
    case failure(String)
}
