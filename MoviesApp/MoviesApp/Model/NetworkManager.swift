//
//  MovieManager.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 12/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import Foundation
import UIKit

public class NetworkManager{
    
    static let shared = NetworkManager(baseURL: "https://api.themoviedb.org/3/movie/popular?api_key=bd67e085700f352302ea910f619fe7ec&language=en-US&page=", initialPage: "1")
    

    
    let baseURL: String
    var initialPage: String
    
    
    init(baseURL:String, initialPage: String) {
        self.baseURL = baseURL
        self.initialPage = initialPage
    }
    
    static func makeGetRequest<T:DataObject>(to endpoint:String, page: String, objectType: T.Type, completionHandler: @escaping (DataObject?, Error?) -> Void) {
        
        let targetUrl = endpoint + page
        print(targetUrl)
        
        guard let url = URL(string: targetUrl) else {
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
    
    static func makeImageRequest(to baseUrl: String, imagePath: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
        let session = URLSession(configuration: .default)
        let endpoint = baseUrl + imagePath
        //let endpoint = "https://image.tmdb.org/t/p/w500/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg"
        let endUrl = URL(fileURLWithPath: endpoint)
        print(endpoint)
    }
    
}

protocol DataObject: Codable {
    
}
