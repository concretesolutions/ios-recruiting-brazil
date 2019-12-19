//
//  BasicRoute.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

public struct BasicRoute: Route {
    public var baseURL: URL
    public var path: String = ""
    public var method: HttpMethod = .get
    public var urlParams: [URLQueryItem] = []
    
    public init(url: URL) {
        self.baseURL = url
    }
    
    var completeUrl: URL? {
        return baseURL
    }
}
