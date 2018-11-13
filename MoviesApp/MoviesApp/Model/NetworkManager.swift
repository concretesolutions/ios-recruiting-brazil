//
//  MovieManager.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 12/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import Foundation

public class NetworkManager{
    
    static let shared = NetworkManager(baseURL: "https://api.themoviedb.org/3/movie/now_playing?api_key=bd67e085700f352302ea910f619fe7ec&language=en-US&page=1")
    let baseURL: String
    
    
    init(baseURL:String) {
        self.baseURL = baseURL
    }
    
    static func makeGetRequest<T:DataObject>(to endpoint:String, objectType: T.Type, completionHandler: @escaping (DataObject?, Error?) -> Void) {
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            completionHandler(nil, NSError(domain: "dsa", code: 01, userInfo: nil))
            return
        }
        var urlRequest = URLRequest(url: url)
        
       
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                //print(String.init(data: responseData, encoding: String.Encoding.utf8)!)
                let dataObject = try decoder.decode(objectType, from: responseData)
                completionHandler(dataObject, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
}

protocol DataObject: Codable {
    
}
