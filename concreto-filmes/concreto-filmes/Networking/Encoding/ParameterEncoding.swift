//
//  ParameterEncoding.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
