//
//  Service.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
typealias Headers = [String: String]

protocol Service {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
