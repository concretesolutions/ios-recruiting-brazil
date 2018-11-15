//
//  MovieDBErrorResponse.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 14/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import Foundation

public struct ResponseError: Decodable {
    
    enum CodingKeys: String, CodingKey
    {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
    let statusCode:Int
    let statusMessage:String?
    
    public init (statusCode:Int = 0, statusMessage:String? = nil) {
        self.statusCode = statusCode
        self.statusMessage = statusMessage
    }
}
