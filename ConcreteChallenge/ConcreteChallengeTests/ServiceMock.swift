//
//  ServiceMock.swift
//  ConcreteChallengeTests
//
//  Created by Matheus Oliveira Costa on 18/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation
@testable import Movs

enum ServiceMock: Service {
    case basicRequest
    case requestWithHeaders
    case requestWithBody(Encodable)

    var baseURL: URL {
        return URL(string: "https://www.example.com")!
    }

    var path: String {
        return "/basic-request"
    }

    var method: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .requestWithBody(let body):
            return .requestWithBody(body)
        default:
            return .requestPlain
        }
    }

    var headers: Headers? {
        switch self {
        case .requestWithHeaders:
            return ["test-key": "test-value"]
        default:
            return nil
        }
    }

    var parametersEncoding: ParametersEncoding {
        switch self {
        case .requestWithBody:
            return .json
        default:
            return .url
        }
    }

}
