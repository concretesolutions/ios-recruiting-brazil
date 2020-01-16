//
//  NetworkServiceMock.swift
//  NetworkLayerTests
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Foundation
import NetworkLayer

enum NetworkServiceMock {
    case success
    case decodeError
    case redirectingError
    case clientError
    case serverError
    case unknownError
    case error
    case post(UserMock)
}

extension NetworkServiceMock: NetworkService {
    var baseURL: URL { URL(string: TestConstants.host.rawValue)! }

    var path: String {
        switch self {
        case .success:
            return TestConstants.Path.success.rawValue
        case .decodeError:
            return TestConstants.Path.decodeError.rawValue
        case .redirectingError:
            return TestConstants.Path.redirectingError.rawValue
        case .clientError:
            return TestConstants.Path.clientError.rawValue
        case .serverError:
            return TestConstants.Path.serverError.rawValue
        case .unknownError:
            return TestConstants.Path.unknownError.rawValue
        case .error:
            return TestConstants.Path.error.rawValue
        case .post:
            return TestConstants.Path.post.rawValue
        }
    }

    var method: HTTPMethod {
        switch self {
        case .post:
            return .post
        default:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .post(let user):
            return .requestBodyParameters(user)
        default:
            return .requestPlain
        }
    }

    var headers: Headers? {
        switch self {
        case .post:
            return ["Test": "test"]
        default:
            return nil
        }
    }
}
