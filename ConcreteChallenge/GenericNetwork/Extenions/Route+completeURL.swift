//
//  Route+completeURL.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

public extension Route {
    /// This is a convenience variable for joining baseURL+path+urlParams
    var completeUrl: URL? {
        let urlComponents = URLComponents(routeType: self)
        return urlComponents?.url
    }
}
