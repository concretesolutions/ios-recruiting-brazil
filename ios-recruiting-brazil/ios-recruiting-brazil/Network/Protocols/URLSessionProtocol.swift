//
//  URLSessionProtocol.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
protocol URLSessionProtocol {
    func dataTask(with url: URLRequest, result:
        @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTaskProtocol
}
