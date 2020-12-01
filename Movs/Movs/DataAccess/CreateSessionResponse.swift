//
//  CreateSessionResponse.swift
//  Movs
//
//  Created by Gabriel Coutinho on 30/11/20.
//

import Foundation

struct CreateSessionResponse: TMDBResponse {
    let success: Bool
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case success,
             id = "session_id"
    }
}
