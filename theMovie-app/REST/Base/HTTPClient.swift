//
//  HttpClientConsumer.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

protocol HTTPClient {
    
    func perform<T: Decodable>(_ request: URLRequest, _ completion: @escaping (Result<T, APIError>) -> Void)
}

class HTTP: HTTPClient {
    
    private let session: URLSession = .shared
    
    func perform<T: Decodable>(_ request: URLRequest,
                               _ completion: @escaping (Result<T, APIError>) -> Void) {
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completion(.failure(.taskError(error: error)))
            } else {
                DispatchQueue.main.async {
                    guard let response = response as? HTTPURLResponse else {
                        completion(.failure(.noResponse))
                        return
                    }

                    if response.statusCode == 200 {
                        guard let data = data else { return }
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let model = try decoder.decode(T.self, from: data)
                            completion(.success(model))
                        } catch  {
                            completion(.failure(.decodingFailure))
                        }
                    } else {
                        completion(.failure(.responseStatusCode(code: response.statusCode)))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
