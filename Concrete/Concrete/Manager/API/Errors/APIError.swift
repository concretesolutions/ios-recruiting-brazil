//
//  APIError.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 11/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import Foundation

extension APIManager {
    enum APIError: Error {
        case encoding
        case decoding
        case server(message: String)
    }
}


