//
//  BaseService.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Alamofire

enum HTTPResponseCode: Int {
    case disconnected = 0
    case timeOutSec = 60
    case success = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case timeOut = 408
    case unprocessableEntity = 422
    case internalServerError = 500
    case badGateway = 502
}

class BaseService {
    
    static var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    static var moviedbApiKey: String {
        return "28cc3b7aa0b6f99f8b8d0175b5ae8337"
    }
    
    fileprivate var kDomainDefault: String {
        return "Request.Error"
    }
    
    typealias RequestCompletion = (_ code: Int?,
        _ result: AnyObject?,
        _ error: Error?) -> ()

    func serviceResponse(method: HTTPMethod,
                         path: String,
                         parameters: [String: Any]? = nil,
                         headers: [String: String]? = nil,
                         completion: @escaping RequestCompletion) {
        let encoded = (BaseService.baseURL + path).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        var requestParameters = parameters ?? [:]
        requestParameters["api_key"] = BaseService.moviedbApiKey
        var encoding: ParameterEncoding!
        switch method {
        case .get:
            encoding = URLEncoding.queryString
        default:
            encoding = JSONEncoding.default
        }
        
        Alamofire.request(encoded, method: method, parameters: requestParameters, encoding: encoding, headers: headers).responseJSON { response in//.request(encoded, headers: requestHeaders).responseJSON { response in
            switch response.result {
            case .success(let jsonData):
                let entries = jsonData as AnyObject?
                completion(response.response?.statusCode, entries, nil)
            case .failure(let error):
                if let code: Int = response.response?.statusCode {
                    completion(code, nil, error)
                    return
                }
                
                completion(HTTPResponseCode.disconnected.rawValue, nil, error as NSError?)
            }
        }
    }
}
