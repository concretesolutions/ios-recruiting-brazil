//
//  MovieDataManager.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 12/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class MovieDataManager {
    
    // MARK: - Properties
    static var movies: [Movie] = []
    static var genres: [Genre] = []
    
    static private var page: Int = 1
    
    // The api_key should be into the info.plist but its here for easy testing
    static private let getPopularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=0aa2fda064d1eec9e68bccc4220ddf7b&language=en-US&page="
    static private let getGenresURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=0aa2fda064d1eec9e68bccc4220ddf7b&language=en-US"
    
    // MARK: - Functions
    static func fetchPopularMovies(completion: @escaping (_ movies: [Movie]?) -> Void) {
        guard let popularMoviesURL = URL(string: self.getPopularMoviesURL + String(self.page)) else { return }
        var request = URLRequest(url: popularMoviesURL)
        request.httpMethod = "GET"
        
        // Increment page number for the next request
        // It is here because if there is any errors in one page it will fetch the next page
        self.page += 1
        
        // Making GET api request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    // Decode it into a PopularMoviesResponse with Movies
                    let popularMoviesResponse = try decoder.decode(PopularMoviesResponse.self, from: data)
                    self.movies.append(contentsOf: popularMoviesResponse.results)
                    
                    completion(self.movies)
                } catch let decoderError {
                    print("Error decoding json: ", decoderError)
                    completion(nil)
                }
            } else {
                print("Error requesting popular movies: ", error as Any)
                completion(nil)
            }
        }.resume()
    }
    
    static func fetchGenres(completion: @escaping (_ status: RequestStatus) -> Void) {
        
        if !self.genres.isEmpty {
            completion(.success)
            return
        }
        
        guard let genresURL = URL(string: self.getGenresURL) else { return }
        var request = URLRequest(url: genresURL)
        request.httpMethod = "GET"
        
        // Making GET api request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    
                    // Decode it into Genres
                    let genresResponse = try decoder.decode(GenresResponse.self, from: data)
                    self.genres = genresResponse.genres
                    
                    completion(.success)
                } catch let decoderError {
                    print("Error decoding json: ", decoderError)
                    completion(.failed)
                }
            } else {
                print("Error requesting genres: ", error as Any)
                completion(.failed)
            }
        }.resume()
    }
}
