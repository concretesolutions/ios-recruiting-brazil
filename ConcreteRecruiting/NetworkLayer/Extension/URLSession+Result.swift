//
//  URLSession+Result.swift
//  NetworkLayer
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

extension URLSession {
    
    public func dataTask(with request: URLRequest, resultCompletion: @escaping (Result<(Data, URLResponse), Error>) -> Void) -> URLSessionDataTask {
        
        return dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                return resultCompletion(.failure(error))
            }
            
            guard let data = data, let response = response else {
                return resultCompletion(.failure(NetworkError.apiError))
            }
            
            resultCompletion(.success((data, response)))
            
        }
        
    }
    
}
