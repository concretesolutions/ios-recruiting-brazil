//
//  URLRequest+EndPoint.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import Foundation

extension URLRequest {
    init(endPoint: RouterService) {
        let urlComponents = URLComponents(endPoint: endPoint)
        self.init(url: urlComponents.url!)
        
        httpMethod = endPoint.method.rawValue
        
        endPoint.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        if case let .requestWithBody(payload) = endPoint.task,
            endPoint.parametersEncoding == .json {
            httpBody = payload.dataValue
        }
    }
}
