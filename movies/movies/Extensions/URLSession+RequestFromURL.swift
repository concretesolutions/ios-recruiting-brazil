//
//  URLSession+RequestFromURL.swift
//  movies
//
//  Created by Jacqueline Alves on 04/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

enum URLSessionError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

extension URLSession {
    func request(from url: URL?, params: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = url else { // Check if request returned an error
            completion(.failure(URLSessionError.invalidURL))
            return
        }
        
        self.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            // Check if the http response status code is >= 200 and <= 300
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(URLSessionError.invalidResponse))
                return
            }
            
            guard let data = data else { // Check if returned any data
                completion(.failure(URLSessionError.noData))
                return
            }
            
            completion(.success(data))
            
        }.resume()
    }
}
