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
    
    private let apiUrl : URL?
    var movies = [Dictionary<String,Any>]()
    
    init() {
        self.apiUrl = URL(string: APILinks.moviesPlayingNow.value)
    }
    
    func requestMovies(completion: @escaping ( [Dictionary<String,Any>]?) -> ()) {
        
        guard let url = apiUrl else {return}
        
        let request = URLRequest(url: (url) , cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task : URLSessionDataTask = session.dataTask(with: request) { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    if let _movies = responseDictionary.value(forKey: "results") as? [Dictionary<String,Any>] {
                        self.movies = _movies
                            completion(_movies)
                    }
                }
            }else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func requestImage(from api: String, name: String, imageFormate: String,completion: @escaping (UIImage?) -> () ) {
        
        let pathImage = String(api).appending(name)
        let imgUrl = URL(string: pathImage)
        if let contentFilePath = imgUrl {
            do {
                let data = try Data(contentsOf: contentFilePath)
                let img = UIImage(data: data)
                completion(img)
            }catch {
                print("Don`t success in get API image.")
                completion(nil)
            }
        }
    }
}
