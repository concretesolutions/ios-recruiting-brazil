//
//  ApiConstants.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Alamofire
import RxSwift

//The header fields
enum HttpHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case qm2ApiKey = "x-application-id"
    case requestId = "x-request-id"
}

//The content type (JSON)
enum ContentType: String {
    case json = "application/json"
}
