//
//  TmdbAPI.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 15/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

class TmdbAPI {
    // Static Properties
    
    static private(set) var popularMoviePages: Set<PopularMoviePage> = []
    
    // Static Methods
    
    static func fetchPopularMovies(forPage page: Int = 1) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=72ee2814ce7d37165e7a836cc8cf9186&page=\(page)") else { return }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard
                let resource = data, error == nil,
                let page = TmdbAPI.decodeJSONFile(from: resource, to: PopularMoviePage.self)
            else { return }
            TmdbAPI.popularMoviePages.insert(page)
        }
        task.resume()
    }
    
    static func decodeJSONFile<T>(from jsonResource: Data, to type: [T].Type) -> [T] where T: Decodable {
        if let decoded = try? JSONDecoder().decode(type, from: jsonResource) {
            return decoded
        }
        else {
            print("Decode from json error")
            return []
        }
    }
    static func decodeJSONFile<T>(from jsonResource: Data, to type: T.Type) -> T? where T: Decodable {
        if let decoded = try? JSONDecoder().decode(type, from: jsonResource) {
            return decoded
        }
        else {
            print("Decode from json error")
            return nil
        }
    }
    
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    private init() {
        
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
}
