//
//  APIDataManager.swift
//  Movies
//
//  Created by Renan Germano on 12/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class APIDataManager {
    
    // MARK: - Types definition
    private struct RequestURL { ///w300/wdcc8n9BB5gO5Y7zIhHLSzxSTc6.jpg
        private static let apiKey: String = "a843669bd8c7b0e6643bbd5be9dcacb3"
        private static let host: String = "https://api.themoviedb.org/3"
        
        static var readPopular: String { return host + "/movie/popular?api_key=" + apiKey }
        static var readGenres: String { return host + "/genre/movie/list?api_key=" + apiKey }
        
        static func readPopularFor(page: Int) -> String { return "\(readPopular)&page=\(page)" }
        
        private static let imageHost: String = "https://image.tmdb.org/t/p"
        private static let posterSize: String = "/w300"
        
        static func readPosterImage(withCode posterCode: String) -> String { return imageHost + posterSize + posterCode }
    }
    
    // MARK: - Functions
    
    static func readPopularFor(page: Int, callback: @escaping ([Movie])->()) {
        if let url = URL(string: RequestURL.readPopularFor(page: page)) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(PopularResult.self, from: data)
                        callback(result.results)
                    } catch {
                        print("Impossible to decode to [Movie] from data.")
                    }
                    
                }
            }
            task.resume()
        } else {
            
        }
    }
    
    static func readGenres(callback: @escaping ([Genre])->()) {
        if let url = URL(string: RequestURL.readGenres) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(GenresResult.self, from: data)
                        callback(result.genres)
                    } catch {
                        print("Impossible to decode to [Movie] from data.")
                    }
                    
                }
            }
            task.resume()
        } else {
            
        }
    }
    
    static func readPosterImage(withCode posterCode: String, callback: @escaping ((UIImage?)->())) {
        if let url = URL(string: RequestURL.readPosterImage(withCode: posterCode)) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data {
                    let image = UIImage(data: data)
                    callback(image)
                }
            }
            task.resume()
        } else {
            
        }
    }
    
}

// MARK: - Helper classes

fileprivate class PopularResult: Decodable {
    var results: [Movie]
}

fileprivate class GenresResult: Decodable {
    var genres: [Genre]
}
