//
//  EndpointProtocol.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias HTTPParameters = [String: String]

protocol EndpointProtocol {
    var scheme: HTTPScheme { get }
    var host: String { get }
    var path: String { get }
    var apiKey: String { get }
    var parameters: HTTPParameters { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}
