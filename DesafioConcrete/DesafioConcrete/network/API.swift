//
//  API.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation
import Alamofire

final class Endpoints {
    static public let shared = Endpoints()
    
    let imageBaseUrl = "https://image.tmdb.org/t/p/"
    
    func getPopularMovies(page: Int) -> String {
        return "https://api.themoviedb.org/3/movie/popular?api_key=3fb52b92aacb2bb3071510634ce7e491&language=pt-BR&page=\(page)"
    }
    
    func getGenreList() -> String {
        return "https://api.themoviedb.org/3/genre/movie/list?api_key=3fb52b92aacb2bb3071510634ce7e491&language=pt-BR"
    }
    
    func makeRequest(apiUrl : String, method: HTTPMethod, callback:@escaping (DataResponse<Any>?) -> ()){
        let url = apiUrl
        
        Alamofire.request(url, method: .get).responseJSON { response in
            callback(response)
        }
    }
    
    private init() {
        
    }
}


