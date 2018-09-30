//
//  DataError.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper
import Moya

public enum DataError: Swift.Error {
    case jsonParse(JSONParseError, Response)
    case jsonMapping(Response)
    case statusCode(Response)
    case realm(message: String)
    case underlying(Swift.Error)
}

public enum JSONParseError: Swift.Error {
    case invalid(Any)
    case convertibleError(value: Any?, type: Any.Type)
    case customError(field: String?, message: String)
    case invalidRawValueError(field: String, value: Any, type: Any.Type)
    case missingFieldError(field: String)
    case typeMismatchError(field: String, value: Any, type: Any.Type)
}

extension DataError {
    static internal func fromMoya(_ error: Moya.MoyaError) -> DataError {
        switch error {
        case .imageMapping,
             .stringMapping,
             .requestMapping,
             .encodableMapping,
             .parameterEncoding,
             .underlying:
            return .underlying(error)
        case let .jsonMapping(response):
            return .jsonMapping(response)
        case let .statusCode(response):
            return .statusCode(response)
        case let .objectMapping(_, response):
            return .jsonMapping(response)
        }
    }
}

extension JSONParseError {
    static internal func fromModelMapper(_ error: MapperError) -> JSONParseError {
        switch error {
        case let .convertibleError(value, type):
            return .convertibleError(value: value, type: type)
        case let .customError(field, message):
            return .customError(field: field, message: message)
        case let .invalidRawValueError(field, value, type):
            return .invalidRawValueError(field: field, value: value, type: type)
        case let .missingFieldError(field):
            return .missingFieldError(field: field)
        case let .typeMismatchError(field, value, type):
            return .typeMismatchError(field: field, value: value, type: type)
        }
    }
}
