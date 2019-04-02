//
//  APIRouter.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import Foundation
import Alamofire

class APIRouter {
    static func getPopularMovies(page: Int) -> URLRequestConvertible {
        
        
        var urlComponents = URLComponents(string: Defines.baseURL + Defines.popularMovies)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Defines.key),
            URLQueryItem(name: "language", value: Defines.language),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request as URLRequestConvertible
    }
    
}
