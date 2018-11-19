//
//  MoviesAPI.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import Keys

struct MoviesAPIConfig {
    fileprivate static let keys = MoviesAppKeys()
    static let apikey = keys.aPIKey
}

enum Result<T> {
    case success(T)
    case error(Error)
}

protocol MoviesService{
    func fetchPopularMovies(callback: @escaping  (Result<[Movie]>) -> Void)
    func fetchGenre(callback: @escaping (Result<[Genre]>) -> Void)
}

class MoviesServiceImplementation: MoviesService{
    
    var baseUrl:String = "https://api.themoviedb.org/3/"
    
    func fetchPopularMovies(callback: @escaping (Result<[Movie]>) -> Void) {
//        let request = "https://api.themoviedb.org/3/movie/popular?api_key=059b457034e531c9b057bd395f9fe913"
        
        let popularMoviesRequest = "movie/popular?api_key="
        let request = self.baseUrl + popularMoviesRequest + MoviesAPIConfig.apikey
        
        let url = URL(string: request)
        
        let task = URLSession.shared.dataTask(with: url!){ data, response, error in
            guard let data = data else{
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do{
                let responseObj = try jsonDecoder.decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    callback(.success(responseObj.results))
                }
            }catch{
                callback(.error(error))
            }
        }
        task.resume()
    }
    
    func fetchGenre(callback: @escaping (Result<[Genre]>) -> Void){
//        let request = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(MoviesAPIConfig.apikey)&language=en-US"
        let genresRequest = "genre/movie/list?api_key="
        let languageRequest = "&language=en-US"
        let request = self.baseUrl + genresRequest + MoviesAPIConfig.apikey + languageRequest
        
        guard let url = URL(string: request) else {return}
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else {return}
            
            let jsonDecoder = JSONDecoder()
            
            do{
                let responseObj = try jsonDecoder.decode(GenreResponse.self, from: data)
                DispatchQueue.main.async {
                    callback(.success(responseObj.genres))
                }
            }catch{
                callback(.error(error))
            }
        }
        task.resume()
    }
}
