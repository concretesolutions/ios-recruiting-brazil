//
//  MoviesAPI.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation

struct MoviesAPIConfig {
    static let apikey = "059b457034e531c9b057bd395f9fe913"
}

enum Result<T> {
    case success(T)
    case error(Error)
}

protocol MoviesService{
    func fetchPopularMovies(request:APIRequest, query:String?, page:Int?, callback: @escaping  (Result<MovieResponse>) -> Void)
    func fetchGenre(callback: @escaping (Result<[Genre]>) -> Void)
}

enum APIRequest:String{
    case base = "https://api.themoviedb.org/3/"
    case fecthPopularMovies = "movie/popular"
    case searchMovie = "search/movie"
    case fetchGenres = "genre/movie/list"
    case fetchImage = "https://image.tmdb.org/t/p/w500"
}

class MoviesServiceImplementation: MoviesService{
    
    var isFetchInProgress = false
    
    func fetchPopularMovies(request: APIRequest, query:String? = nil, page:Int? = nil, callback: @escaping (Result<MovieResponse>) -> Void) {
        
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        var components = URLComponents(string: APIRequest.base.rawValue + request.rawValue)
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: MoviesAPIConfig.apikey),
        ]
        
        if let query = query?.replacingOccurrences(of: " ", with: "%20"){
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
            
        if let page = page{
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        components?.queryItems = queryItems
        guard let url = components?.url else{
            callback(.error(NSError()))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else{
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do{
                let responseObj = try jsonDecoder.decode(MovieResponse.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.isFetchInProgress = false
                    callback(.success(responseObj))
                }
            }catch{
                DispatchQueue.main.async { [weak self] in
                    self?.isFetchInProgress = false
                    callback(.error(error))
                }
                
            }
        }
        task.resume()
    }
    
    func fetchGenre(callback: @escaping (Result<[Genre]>) -> Void){
        var components = URLComponents(string: APIRequest.base.rawValue + APIRequest.fetchGenres.rawValue)
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: MoviesAPIConfig.apikey),
            ]
        
        components?.queryItems = queryItems
        guard let url = components?.url else{
            callback(.error(NSError()))
            return
        }
        
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
