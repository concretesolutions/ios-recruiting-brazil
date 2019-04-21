//
//  ApiErros.swift
//  Movs
//
//  Created by Ygor Nascimento on 20/04/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import Foundation

enum ApiError {
    //Unable to create url
    case url
    
    //Session dataTask error
    case taskError(error: Error)
    
    //Session dataTask response error
    case noResponse
    
    //Session dataTask data error
    case noData
    
    //Session dataTask statuscode error
    case responseStatusCode(code: Int)
    
    //JSON decode error
    case invalidJSON
}
