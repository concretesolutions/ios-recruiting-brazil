//
//  Bases.swift
//  Headlines
//
//  Created by Lorien Moisyn on 14/03/19.
//  Copyright © 2019 Lorien Moisyn. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public enum HTTPStatusCode: Int {

    case unknown = -1
    case internalServerError = 500
    case unauthorized = 401
    case badRequest = 400
    case notFound = 404

}

public extension HTTPStatusCode {

    public static func from(_ response: HTTPURLResponse) -> HTTPStatusCode {
        return HTTPStatusCode(rawValue: response.statusCode)!
    }

}


public extension HTTPURLResponse {

    var status: HTTPStatusCode {
        return HTTPStatusCode(rawValue: self.statusCode) ?? HTTPStatusCode.unknown
    }

}
