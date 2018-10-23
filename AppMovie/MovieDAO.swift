//
//  MovieDAO.swift
//  AppMovie
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import Foundation

//
//  FilmeDAO.swift
//  AppFilmes
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit


class MovieDAO {
    
    static let shared = MovieDAO()
    private let apiKey = "ad2a4bfff8f6571c51c072374044a33"
    private let apiUrl = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=1ad2a4bfff8f6571c51c072374044a33")!
    var movies = [NSDictionary]()
    
    init() {
        
    }
    
    func requestMovies(completion: @escaping ( [NSDictionary]?) -> ()) {
        let request = URLRequest(url: (self.apiUrl) , cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task : URLSessionDataTask = session.dataTask(with: request) { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.movies = responseDictionary.value(forKey: "results") as! [NSDictionary]
                    completion(self.movies)
                }
            }else {
                completion(nil)
            }
        }
        task.resume()
    }
}
