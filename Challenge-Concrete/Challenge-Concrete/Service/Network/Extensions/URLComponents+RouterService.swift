//
//  URLComponents+RouterService.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

extension URLComponents {
    init(endPoint: RouterService) {
        let baseURL = URL(string: endPoint.baseURL)
        let url = baseURL?.appendingPathComponent(endPoint.path)
        self.init(url: url!, resolvingAgainstBaseURL: false)!
        
        if case let .requestWithQuery(parameters) = endPoint.task,
            endPoint.parametersEncoding == .url {
            
            queryItems = parameters.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
        }
    }
}
