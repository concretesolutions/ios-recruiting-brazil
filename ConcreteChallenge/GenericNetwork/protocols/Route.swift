//
//  Route.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

import Foundation

/// A protocol for types that can make a Route.
/// Usually, each of the final applications has a Enum, and it has a case for each route.
public protocol Route {
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var urlParams: [URLQueryItem] { get }
}
