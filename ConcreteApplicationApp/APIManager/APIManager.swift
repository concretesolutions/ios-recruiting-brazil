//
//  APIManager.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 14/11/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

struct ErrorAPI {
    static let code0 = "Error in creating base URL."
    static let code1 = "Could not receive data."
}
class APIManager{
    
    //FIXME:- create a better encapsulament
    static let shared = APIManager(endpoint: "https://api.themoviedb.org/3/movie/76341?api_key=9b9f207b503e03a4e0b1267156c23dd2")
    
    // MARK: - Properties
    let endpoint: String
    
    // Initialization
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    //FIXME:- make it static
    func getAllMovies(completionHandler: @escaping ([Any]?, Error?) -> Void) {
        
        guard let url = URL(string: self.endpoint) else{
            print("error in creating URL")
            //FIXME:- create error with better description
               let error = NSError(domain: "APIMAnager", code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorAPI.code0])
            completionHandler(nil,error)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("cache-control", forHTTPHeaderField: "no-cache")
        
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard let responseData = data else {
                let error1 = NSError(domain: "APIMAnager", code: 1, userInfo: [NSLocalizedDescriptionKey: ErrorAPI.code1])
                completionHandler(nil,error1)
                return
            }
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            print(String.init(data: responseData, encoding: String.Encoding.utf8)!)
        }
        task.resume()
    }
    
}
