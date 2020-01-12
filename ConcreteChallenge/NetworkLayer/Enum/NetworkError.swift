//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

public enum NetworkError: LocalizedError {

    case invalidURL
    case emptyResponse
    case emptyData
    case requestError(Error)
    case decodeError(Error)
    case redirectingError(Error?)
    case clientError(Error?)
    case serverError(Error?)
    case unknown

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .emptyResponse:
            return "Empty response"
        case .emptyData:
            return "Empty data"
        case .requestError(let error):
            return "Request error: \(error.localizedDescription)"
        case .decodeError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .redirectingError(let error),
             .clientError(let error),
             .serverError(let error):
            return "Response error: \(error?.localizedDescription ?? "")"
        case .unknown:
            return "Unkown network error"
        }
    }

    public var errorDescription: String? {
        localizedDescription
    }
}
