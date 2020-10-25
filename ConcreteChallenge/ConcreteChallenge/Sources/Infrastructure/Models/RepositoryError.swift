//
//  RepositoryError.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum RepositoryError: Error {
    case unknown
    case dataNotFound
    case invalidJSON

    var errorDescription: String? {
        switch self {
        case .unknown:
            return localizedDescription
        case .dataNotFound:
            return Strings.repositryErrorDataNotFound.localizable
        case .invalidJSON:
            return Strings.repositryErrorParseJSON.localizable
        }
    }
}
