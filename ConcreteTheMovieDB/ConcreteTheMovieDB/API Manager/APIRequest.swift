//
//  APIRequest.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 13/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import Foundation

enum Response<T>{
    case success(T)
    case error(String)
}

class APIRequest {
    
    static private let session = URLSession(configuration: .default)
    typealias completionHandler = (Response<DataProtocol>) -> Void
    
    static func getMovies(completion: @escaping (completionHandler)){
        
        let endpoint = self.endpoint(withResourceName: .nowPlaying)
   
        let task = session.dataTask(with: URLRequest(url: endpoint)){ data, _ , error in
            
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode(Result.self, from: data!)
                completion(Response.success(response))
            }catch{
                print(error)
            }
            
        }
        task.resume()
        
        
    }
    
    static private func endpoint(withResourceName resource: ResourceName) -> URL{
        guard let baseUrl = URL(string: "\(APISupport.baseURL)\(resource.rawValue)\(APISupport.apiKey)") else {
            return URL(fileURLWithPath: "")
        }
        return baseUrl
    }
}
