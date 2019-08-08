//
//  DefaultDataResponse.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct DefaultDataResponse {
    let success: Bool
    let statusCode: Int?
    let data: Data?
    let error: Error?
    
    init(statusCode: Int, data: Data?) {
        self.success = true
        self.statusCode = statusCode
        self.data = data
        self.error = nil
    }
    
    init(error: Error) {
        self.success = false
        self.statusCode = nil
        self.data = nil
        self.error = error
    }
}
