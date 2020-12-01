//
//  RequestTokenResponse.swift
//  Movs
//
//  Created by Gabriel Coutinho on 30/11/20.
//

import Foundation

struct RequestTokenResponse: TMDBResponse {
    let success: Bool
    let expiresAt: Date?
    let requestToken: String
    
    private enum CodingKeys: String, CodingKey {
        case success,
             expiresAt = "expires_at",
             requestToken = "request_token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
         
        success = try values.decode(Bool.self, forKey: .success)
 
        requestToken = try values.decode(String.self, forKey: .requestToken)
        
        let dateString = try values.decode(String.self, forKey: .expiresAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        expiresAt = dateFormatter.date(from: dateString)
    }
}
