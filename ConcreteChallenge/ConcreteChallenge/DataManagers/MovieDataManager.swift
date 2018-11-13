//
//  MovieDataManager.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 12/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

enum RequestStatus {
    case success
    case failed
}

class MovieDataManager {
    
    // MARK: - Properties
    static var movies: [Movie] = []
    
    static let getPopularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=0aa2fda064d1eec9e68bccc4220ddf7b&language=en-US&page=1"
    
    // MARK: - Functions
    static func fetchPopularMovies(completion: @escaping () -> Void) {
        guard let popularMoviesURL = URL(string: self.getPopularMoviesURL) else { return }
        var request = URLRequest(url: popularMoviesURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    
                    let popularMoviesResponse = try decoder.decode(PopularMoviesResponse.self, from: data)
                    self.movies = popularMoviesResponse.results

                    completion()
                } catch let decoderError {
                    print("Error decoding json: ", decoderError)
                }
            } else {
                print("Error requesting popular movies: ", error as Any)
            }
        }.resume()
    }
}
