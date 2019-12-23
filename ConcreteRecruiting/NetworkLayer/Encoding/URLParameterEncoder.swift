//
//  ParameterEncoding.swift
//  NetworkLayer
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    
    static func encode(_ request: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = request.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
        
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let queryItem = URLQueryItem(name: key, value: encodedValue)
                
                urlComponents.queryItems?.append(queryItem)
            }
            
            request.url = urlComponents.url
            
        }
        
        let contentTypeHeader = "Content-Type"
        if request.value(forHTTPHeaderField: contentTypeHeader) == nil {
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: contentTypeHeader)
        }
        
    }
    
}
