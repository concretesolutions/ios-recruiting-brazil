//
//  Service.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class Service {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func cancelActiveTasks() {
        dataTask?.cancel()
    }
    
    func get<T: Decodable>(in url: URL?, completion: @escaping (ResponseResultType<T>) -> Void) {
        guard let url = url else {
            completion(ResponseResultType.fail(NSError(domain: NSURLErrorDomain, code: 1000, userInfo: nil)))
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                completion(.fail(error))
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                Array(200..<300).contains(response.statusCode) {
                do {
                    let decodableObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodableObject))
                }
                catch {
                    completion(ResponseResultType.fail(NSError(domain: "JSONMalformed", code: 1002, userInfo: nil)))
                }
            }
        }
        dataTask?.resume()
    }
}
