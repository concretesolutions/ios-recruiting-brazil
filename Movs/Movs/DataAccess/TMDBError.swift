//
//  TMDBError.swift
//  Movs
//
//  Created by Gabriel Coutinho on 30/11/20.
//

import Foundation

struct TMDBError: TMDBResponse {
    let success: Bool = false
    let statusMessage: String
    let statusCode: Int
    
    private enum CodingKeys: String, CodingKey {
        case success,
             statusMessage = "status_message",
             statusCode = "status_code"
    }
}
