//
//  URLComponents+Service.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

extension URLComponents {
    init?(service: Service) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)

        guard case let .requestParameters(parameters) = service.task,
            service.parametersEncoding == .url else { return }

        self.queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
    }
}
