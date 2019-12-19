//
//  Route+initRouteType.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

public extension URLComponents {
    
    /// initilizes a URLComponents with a Route type
    init?(routeType: Route) {
        self.init(string: routeType.baseURL.absoluteString)
        self.path = routeType.path
        self.queryItems = routeType.urlParams
    }
}
