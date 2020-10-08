//
//  HTTPMethod.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

    func toString() -> String {
        return self.rawValue
    }
}
