//
//  ErrorHandling.swift
//  Headlines
//
//  Created by Lorien Moisyn on 14/03/19.
//  Copyright © 2019 Lorien Moisyn. All rights reserved.
//

import Foundation

public enum RestError: Error {

    case unknown(response: HTTPURLResponse, data: Data?)
    case noConnection
    case badRequest(response: HTTPURLResponse, data: Data?)
    case internalServerError(response: HTTPURLResponse, data: Data?)
    case unauthorized(response: HTTPURLResponse, data: Data?)

}

public extension RestError {

    public static func from(_ response: HTTPURLResponse, _ data: Data?) -> RestError {
        switch response.status {
        case .badRequest:
            return .badRequest(response: response, data: data)
        case .internalServerError:
            return .internalServerError(response: response, data: data)
        case .unauthorized:
            return .unauthorized(response: response, data: data)
        default:
            return .unknown(response: response, data: data)
        }
    }

}
