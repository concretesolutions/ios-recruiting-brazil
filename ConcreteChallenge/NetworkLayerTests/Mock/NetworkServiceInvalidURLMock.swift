//
//  NetworkServiceInvalidURLMock.swift
//  NetworkLayerTests
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Foundation
import NetworkLayer

enum NetworkServiceInvalidURLMock {
    case invalidURL
}

extension NetworkServiceInvalidURLMock: NetworkService {
    var baseURL: URL { URL(string: TestConstants.invalidHost.rawValue)! }

    var path: String { String() }
    var method: HTTPMethod { .get }
    var task: HTTPTask { .requestPlain }
    var headers: Headers? { nil }
}
