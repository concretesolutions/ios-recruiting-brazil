//
//  GetConfiguration.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 16/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import Foundation

struct GetConfiguration: APIRequest {
    typealias Response = ResponseConfiguration
    
    var endpoint: String {
        return "configuration"
    }
    
}
