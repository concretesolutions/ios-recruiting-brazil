//
//  NetworkSessionDataTaskMock.swift
//  NetworkLayerTests
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import NetworkLayer

struct NetworkSessionDataTaskMock: NetworkSessionDataTask {
    private (set) var running = false

    var state: URLSessionTask.State {
        running ? .running : .canceling
    }

    mutating func resume() {
        running = true
    }

    mutating func cancel() {
        running = false
    }
}
