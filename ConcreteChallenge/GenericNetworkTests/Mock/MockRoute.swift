//
//  MockRoute.swift
//  GenericNetworkTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
@testable import GenericNetwork

struct MockRoute: Route {
    var baseURL: URL
    
    var path: String
    
    var method: HttpMethod
    
    var urlParams: [URLQueryItem]    
}
