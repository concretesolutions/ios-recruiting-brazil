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
    func fetchPopularMovies(request:APIRequest, query:String?, page:Int?, callback: @escaping  (Result<MovieResponse>) -> Void)
    func fetchGenre(callback: @escaping (Result<[Genre]>) -> Void)
}

enum APIRequest:String{
    case fecthPopularMovies = "movie/popular"
    case searchMovie = "search/movie"
    case fetchGenres = ""
}

class MoviesServiceImplementation: MoviesService{
    
    var endpoint:String = "https://api.themoviedb.org/3/"
    var isFetchInProgress = false
    
    func fetchPopularMovies(request: APIRequest, query:String? = nil, page:Int? = nil, callback: @escaping (Result<MovieResponse>) -> Void) {
        
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        var components = URLComponents(string: endpoint + request.rawValue)
        
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
        let genresRequest = "genre/movie/list?api_key="
        let languageRequest = "&language=en-US"
        let request = self.endpoint + genresRequest + MoviesAPIConfig.apikey + languageRequest
        
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
