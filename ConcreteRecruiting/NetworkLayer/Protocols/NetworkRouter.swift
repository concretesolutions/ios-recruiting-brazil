//
//  NetworkRouter.swift
//  NetworkLayer
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (Result<(Data, URLResponse), Error>) -> Void

public protocol NetworkRouter: class {
    
    associatedtype EndPoint: EndPointType
    
    func request<T: Decodable>(_ route: EndPoint, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func cancel()
    
}
