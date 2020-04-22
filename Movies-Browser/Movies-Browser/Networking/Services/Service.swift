//
//  Service.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 19/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

class Service {
    /// A method that request some data to a RestAPI Service.
    class func request<T: Codable>(router: Router, completion: @escaping (T?, Bool) -> ()) {
        let session = URLSession(configuration: .default)
        var components = URLComponents(string: router.url + router.endpoint)
        components?.queryItems = router.parameters.map {
             URLQueryItem(name: $0, value: $1)
        }
        guard let url = components?.url else {
            completion(nil, false)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil, response != nil, let data = data else {
                completion(nil, false)
                return
            }
            
            let response = try? JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                completion(response, true)
            }
        }
        dataTask.resume()
      }
}
