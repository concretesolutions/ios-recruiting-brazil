//
//  URLComponentExtension.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
extension URLComponents {

    /// Constructs the URL according to the service that receives
    /// - Parameter service: The object that specify the needed information to make an http request
    init?(service: Service) {
        if service.path.isEmpty {
            let url = service.baseURL
            self.init(url: url, resolvingAgainstBaseURL: false)
        } else {
            let url = service.baseURL.appendingPathComponent(service.path)
            self.init(url: url, resolvingAgainstBaseURL: false)
        }

        guard case let .requestParameters(parameters) = service.task,
            service.parametersEncoding == .url else {
                return
        }

        self.queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
