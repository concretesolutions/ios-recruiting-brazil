//
//  NetworkError.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

enum NetworkError: Error {
    case unknown
    case clientError(statusCode: Int, dataResponse: String)
    case serverError(statusCode: Int, dataResponse: String)
    case decodeError(Error)
    case noResponseData
    case connectionError(Error)
    case emptyResult
}
