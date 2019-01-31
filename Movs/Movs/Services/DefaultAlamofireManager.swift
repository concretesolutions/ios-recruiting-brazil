//
//  DefaultAlamofireManager.swift
//  Movs
//
//  Created by Brendoon Ryos on 25/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Alamofire

class DefaultAlamofireManager: Alamofire.SessionManager {
  static let sharedManager: DefaultAlamofireManager = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 30
    configuration.requestCachePolicy = .useProtocolCachePolicy
    return DefaultAlamofireManager(configuration: configuration)
  }()
}
