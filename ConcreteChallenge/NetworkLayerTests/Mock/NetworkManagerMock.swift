//
//  NetworkManagerMock.swift
//  NetworkLayerTests
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import NetworkLayer

struct NetworkManagerMock: AnyNetworkManager {
    var task: NetworkSessionDataTaskMock?
    var session: NetworkSessionMock = NetworkSessionMock()

    mutating func request<ServiceType: NetworkService, ResponseType: Decodable>(
        _ endpoint: ServiceType,
        _ completion: @escaping (Result<ResponseType, Error>) -> Void) {

    }

    mutating func cancel() {

    }
}
