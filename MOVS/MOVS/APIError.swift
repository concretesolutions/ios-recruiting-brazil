//
//  APIError.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 20/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

enum APIError: Error{
    case requestFailed
    case invalidData
    case responseErro
    case decodeFailure
    
    var localizedDescription: String {
        switch self {
            case .requestFailed:
                return "Request Failed"
            case .invalidData:
                return "Invalid Data"
            case .responseErro:
                return "Response Error"
            case .decodeFailure:
                return "JSON Parsing Failure"
        }
    }
}
