//
//  URL+Utils.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

extension URLRequest {

    init(with url: URL?) {
        guard let url = url else {
            preconditionFailure("Invalid URL")
        }
        self = URLRequest(url: url)
    }
}
