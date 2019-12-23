//
//  NetworkRouter.swift
//  NetworkLayer
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (Result<(Data?, URLResponse), Error>) -> Void

protocol NetworkRouter: class {
    
    associatedtype EndPoint: EndPointType
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
    
}
