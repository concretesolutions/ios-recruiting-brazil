//
//  NetworkService.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//


import Foundation

enum NetworkResult<T, NetworkError, Int> {
    case success(T, Int)
    case failure(NetworkError, Int)
}

enum NetworkError: Error {
    case undefined
    case withError(error: Error)
    case withContainer(container: CustomError)

    func message() -> String {
        let undefined = "Algo de inesperado aconteceu!"
        switch self {
        case .undefined:
            return undefined
        case .withError(let error):
            return error.localizedDescription
        case .withContainer(let container):
            return container.status_message ?? undefined
        }
    }
    
    func code() -> Int {
        let undefined = -1
        switch self {
        case .withError(let error):
            return (error as NSError).code
        case .withContainer(let container):
            return container.status_code ?? undefined
        default:
            return undefined
        }
    }
}

enum NetworkResponse {
    case success(data: Data, code: Int)
    case failure(error: Error, code: Int)
}

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum Service: String {
    case movieDBv3  = "3"
    case mockv2     = "api/v2"
}

struct NetworkService {
    
    var api: Service = .mockv2
    var base: String = ""
    var path: String = ""
    var url: URL = URL(fileURLWithPath: "")
    var parameters: [String : Any]? = nil
    
    init(parameters: [String : Any]? = nil) {
        self.parameters = self.defaults(with: parameters)
    }
    
    init(api: Service, path: String, parameters: [String : Any]? = nil) {
        switch api {
        case .movieDBv3:
            if let hosts = EnvironmentUtil.hosts, let base = hosts.movieDB {
                self.base = base
            }
        case .mockv2:
            self.base = "http://www.mocky.io"
        }
        
        self.api = api
        self.path = path
        self.parameters = self.defaults(with: parameters)
        
        if let url = URL(string: self.base) {
            self.url = url.appendingPathComponent(api.rawValue).appendingPathComponent(self.path)
        }
    }
    
    private func defaults(with parameters: [String : Any]? = nil) -> [String : Any] {
        let movieDBKey = EnvironmentUtil.keys?.movieDBKEY ?? ""
        
        var defaults: [String : Any] = ["api_key" : movieDBKey]

        parameters?.forEach {
            defaults.updateValue($0.value, forKey: $0.key)
        }
        
        return defaults
    }
    
}
