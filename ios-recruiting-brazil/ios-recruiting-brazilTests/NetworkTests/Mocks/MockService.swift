//
//  MockService.swift
//  ios-recruiting-brazilTests
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
@testable import ios_recruiting_brazil
enum MockService: Service {
    
    case get
    
    var baseURL: URL {
        switch self {
        case .get :
            guard let url = URL(string: "https://mockurl") else {
                fatalError("URL can't be empty")
            }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .get:
            return "mockpath"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .get:
            return .requestPlain
        }
    }
    
    var headers: Headers? {
        switch self {
        case .get:
            return nil
        }
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .get:
            return .url
        }
    }
    
    
}
