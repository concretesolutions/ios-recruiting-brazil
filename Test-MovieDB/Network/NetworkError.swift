//
//  NetworkError.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation

public enum LoadError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}
