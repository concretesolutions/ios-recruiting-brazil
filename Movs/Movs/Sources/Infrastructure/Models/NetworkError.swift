//
//  ProviderError.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum NetworkError: Error {
    case unknown
    case taskError(error: Error)
    case dataNotFound
    case invalidJSON

    // MARK: - Computed variables

    var errorDescription: String {
        switch self {
        case .unknown:
            return localizedDescription
        case .taskError(let error):
            return error.localizedDescription
        case .dataNotFound:
            return Strings.repositryErrorDataNotFound.localizable
        case .invalidJSON:
            return Strings.repositryErrorParseJSON.localizable
        }
    }
}
