//
//  NetworkSessionDataTask.swift
//  NetworkLayer
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

public protocol NetworkSessionDataTask {
    var state: URLSessionDataTask.State { get }

    mutating func resume()
    mutating func cancel()
}

extension URLSessionDataTask: NetworkSessionDataTask {}
