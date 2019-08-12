//
//  NetworkManager.swift
//  Movs
//
//  Created by Tiago Chaves on 12/08/19.
//  Copyright (c) 2019 Tiago Chaves. All rights reserved.
//
//  This file was generated by Toledo's Swift Xcode Templates
//

import Foundation
import Alamofire

public enum MovsRequests: URLRequestConvertible {

    static let baseURLPath 				= "https://api.themoviedb.org"
    static let baseURI                  = "/3"
    static let completeURL              = "\(MovsRequests.baseURLPath)\(MovsRequests.baseURI)"
	
    case popularMovies(Int)
    
    var method: HTTPMethod {
        switch self {
        case .popularMovies:
            return .get
        }
    }
    
    var baseURL: String{
        switch self{
        case .popularMovies:
            return MovsRequests.completeURL
        }
    }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .popularMovies(let page):
            return ["api_key": apiKey,"language":"en-US","page":page]
        }
    }
    
    var headers:HTTPHeaders {
        switch self {
        case .popularMovies:
            return ["Content-Type":"application/x-www-form-urlencoded"]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

class NetworkManager {
    
    static func request(withURL url:URLRequestConvertible, callback:@escaping (Data?,DataResponse<Any>?,Error?)->Void) {
        
        Alamofire.request(url).validate().responseJSON { response in
            
            NSLog("Requesting: \(url.urlRequest!)")
            
            switch response.result {
            case .success:
                let data = response.data
                NSLog("Request successed!")
                callback(data,response, nil)
            case .failure(let error):
                NSLog("Request failed! \(error.localizedDescription)")
                callback(nil,response, error)
            }
        }
    }
}
