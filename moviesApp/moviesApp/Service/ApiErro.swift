//
//  ApiErro.swift
//  moviesApp
//
//  Created by Victor Vieira Veiga on 04/12/19.
//  Copyright © 2019 Victor Vieira Veiga. All rights reserved.
//

import Foundation

enum ApiErro {
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

