//
//  HTTPScheme.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

enum HTTPScheme: String {
    case http
    case https

    func toString() -> String {
        return self.rawValue
    }
}
