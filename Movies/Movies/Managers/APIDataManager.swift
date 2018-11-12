//
//  APIDataManager.swift
//  Movies
//
//  Created by Renan Germano on 12/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class APIDataManager {
    
    // MARK: - Types definition
    struct RequestURL {
        private static let apiKey: String = "a843669bd8c7b0e6643bbd5be9dcacb3"
        private static let host: String = "https://api.themoviedb.org/3"
        
        static var readPopular: String { return host + "/movie/popular?api_key=" + apiKey }
        static var readGenres: String { return host + "/genre/movie/list?api_key=" + apiKey }
        
    }
    
    // MARK: - Functions
    
    static func readPopular(callback: @escaping ([Movie])->()) {
        let url = URL(string: RequestURL.readPopular)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let movies = try decoder.decode([Movie].self, from: data)
                    callback(movies)
                } catch {
                    print("Impossible to decode to Movie from data.")
                }
            }
        }
    }
    
    static func readGenres(callback: @escaping ([Genre])->()) {
        
    }
    
    
    
}
