//
//  EndPointType.swift
//  NetworkLayer
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
    
    
}
