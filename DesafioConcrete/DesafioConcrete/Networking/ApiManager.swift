//
//  ApiManager.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ApiManager: ApiMethodsProtocol {
    
    static var movieURL: String = "https://api.themoviedb.org/3/movie/popular"
    static var genreURL: String = "https://api.themoviedb.org/3/genre/movie/list"
    static var imageURL: String = "https://image.tmdb.org/t/p/w500"
    static var apiKey: String =  "0570b0af82a221b5511cf9b99c4ffc37"
    static var language: String = "en-US"
    
    static func getGenres(success: @escaping (Data) -> (), failure: @escaping (Error) -> ()) {
        let parameters: Parameters = ["api_key":apiKey, "language": language]
        Alamofire.request(genreURL, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    static func getMovies(page: Int, success: @escaping (Data) -> (), failure: @escaping (Error) -> ()) {
        let parameters: Parameters = ["api_key":apiKey, "language": language,"page": page]
        Alamofire.request(movieURL, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
