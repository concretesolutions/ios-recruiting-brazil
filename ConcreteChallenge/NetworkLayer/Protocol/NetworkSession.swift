//
//  NetworkSession.swift
//  NetworkLayer
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

public protocol NetworkSession {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

    mutating func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult)
    -> NetworkSessionDataTask
}

extension URLSession: NetworkSession {
    public func dataTask(with request: URLRequest,
                         completionHandler: @escaping DataTaskResult) -> NetworkSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
