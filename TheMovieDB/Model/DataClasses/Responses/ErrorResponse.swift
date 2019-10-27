//
//  ErrorResponse.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

struct ErrorResponse: Codable {
    var statusMessage: String?
    var statusCode: Int?
    
    private enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
