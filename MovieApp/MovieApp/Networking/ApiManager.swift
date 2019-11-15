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
        
    func loadMovies(page: Int, completion: @escaping (_ result: [Movie]?, _ error: Bool) -> Void) {
        let url = API.baseURL + API.movie + API.popular
        let parameters: Parameters = ["api_key":API.apiKey, "page": page]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    completion(nil, true)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    completion(result.movieList, false)
                    return
                } catch {
                    completion(nil, true)
                    return
                }
                
            } else {
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
                
                guard let data = response.data else {
                    completion(nil, true)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GenresResult.self, from: data)
                    completion(result.genres, false)
                    return
                } catch {
                    completion(nil, true)
                    return
                }
                
            } else {
                completion(nil,true)
                return
            }
        }
        
    }
    
}

