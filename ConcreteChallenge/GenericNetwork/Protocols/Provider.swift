//
//  Provider.swift
//  GenericNetwork
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// A protocol for types that can provide data from API`s.
/// This protocol can be implemented in multiple ways, using URLSession, Alamofire, Moya or other frameworks. This is usefull, because it makes easier switching between Provider implementations, then your code become more independent of especific things and third party code. It makes also easier implementing Mock Providers for unit tests.
/**
    At **URLSessionDataProvider.swift** file there is an implementation made using URLSession.
    At **LocalMockProvider.swift** file there is an implementation make for helping to mock errors and local data requests
*/
public protocol Provider {
    /// The return type of the provider.
    /// In the majority of the cases this is a Data value.
    /// But in some cases can be URl, when providing Files for example.
    associatedtype ReturnType
    
    /// requests a route and calls a completion at the request end. It can result a Error or a ResultType
    func request(route: Route, completion: @escaping (Result<ReturnType, Error>) -> Void)
}
