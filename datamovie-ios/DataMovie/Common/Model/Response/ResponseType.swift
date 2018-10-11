//
//  ResponseType.swift
//  DataMovie
//
//  Created by Andre on 25/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

enum ResponseType: Int {
    
    case UNDEFINED                  = -1
    case HTTP_CONNECTION            = 0
    case HTTP_TIMEOUT               = -1001
    case HTTP_ALAMOFIRE_CONNECTION  = -1009
    case HTTP_BAD_REQUEST           = 400
    
}

extension ResponseType {
    
    var title: String {
        return "Attention"
    }
    
    var message: String {
        switch self {
        case .HTTP_CONNECTION: fallthrough
        case .HTTP_TIMEOUT: fallthrough
        case .HTTP_ALAMOFIRE_CONNECTION: fallthrough
        case .HTTP_BAD_REQUEST:
            return "Please, check your internet connection."
        case .UNDEFINED: fallthrough
        default:
            return "An unexpected error has occurred, please try again in a moment."
        }
    }
    
}
