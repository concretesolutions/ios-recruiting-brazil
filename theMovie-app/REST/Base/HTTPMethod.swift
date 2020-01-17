//
//  HTTPMethod.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
    
    func toString() -> String {
           return self.rawValue
       }
}
