//
//  NetworkRouter.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter {
    associatedtype EndPoint: EndPointTye
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
