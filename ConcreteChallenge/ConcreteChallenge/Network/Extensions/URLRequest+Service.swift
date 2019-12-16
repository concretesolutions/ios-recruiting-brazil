//
//  URLRequest+Service.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

extension URLRequest {
    init?(service: Service) {
        guard let urlComponents = URLComponents(service: service),
            let url = urlComponents.url else { return nil }

        self.init(url: url)

        httpMethod = service.method.rawValue
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }

        if case let .requestWithBody(payload) = service.task,
            service.parametersEncoding == .json {
            httpBody = payload.encoded()
        }
    }
}
