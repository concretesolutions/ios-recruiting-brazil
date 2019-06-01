//
//  ErrorService.swift
//  GitHubRepository
//
//  Created by Gilson Santos on 26/11/18.
//  Copyright © 2018 Gilson Santos. All rights reserved.
//

import Foundation

enum ErrorType:Error {
    case notFound
    case generic
}

class ErrorService {
    class func verifyStatusCode(responseResult:HTTPURLResponse?) throws{
        if let response = responseResult{
            if response.statusCode == 404{
                throw ErrorType.notFound
            }else if response.statusCode != 200{
                throw ErrorType.generic
            }
        }else{
            throw ErrorType.generic
        }
    }
}
