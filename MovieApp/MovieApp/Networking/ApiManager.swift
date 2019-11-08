//
//  ApiManager.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//


import Foundation
import Alamofire

class ApiManager {
    
    func getMovies(completion: @escaping (_ result: [Movie]?, _ error: Bool) -> Void) {
        let url = API.baseURL + API.movie + API.popular
        let parameters: Parameters = ["api_key":API.apiKey, "page": 1]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                print("Deu certo !! :) - ApiManager - getMovies() \n \(String(describing: response.result.value))")
                
                guard let data = response.data else {
                    completion(nil, true)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    completion(result.movieList, false)
                    return
                }catch {
                    print("Error - JSONDecoder() - ApiManager - getMovies()")
                    completion(nil, true)
                    return
                }
                
            }else {
                print("Não deu 200 :c - ApiManager - getMovies()")
                completion(nil,true)
                return
            }
        }
        
    }
    
    func loadMoreMovies(page: Int, completion: @escaping (_ result: [Movie]?, _ error: Bool) -> Void) {
        let url = API.baseURL + API.movie + API.popular
        let parameters: Parameters = ["api_key":API.apiKey, "page": page]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                print("Deu certo !! :) - ApiManager - loadMoreMovies() \n \(String(describing: response.result.value))")
                
                guard let data = response.data else {
                    completion(nil, true)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    completion(result.movieList, false)
                    return
                }catch {
                    print("Error - JSONDecoder() - ApiManager - loadMoreMovies()")
                    completion(nil, true)
                    return
                }
                
            }else {
                print("Não deu 200 :c - ApiManager - loadMoreMovies()")
                completion(nil,true)
                return
            }
        }
        
    }
    
    func getGenres(completion: @escaping (_ result: [Genre]?, _ error: Bool) -> Void) {
        let url = API.baseURL + API.genre + API.movie + API.list
        let parameters: Parameters = ["api_key":API.apiKey]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                print("Deu certo !! :) - ApiManager - getGenres() \n \(String(describing: response.result.value))")
                
                guard let data = response.data else {
                    completion(nil, true)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GenresResult.self, from: data)
                    completion(result.genres, false)
                    return
                }catch {
                    print("Error - JSONDecoder() - ApiManager - getGenres()")
                    completion(nil, true)
                    return
                }
                
            }else {
                print("Não deu 200 :c - ApiManager - getGenres()")
                completion(nil,true)
                return
            }
        }
        
    }
    
}

