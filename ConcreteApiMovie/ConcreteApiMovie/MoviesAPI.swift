//
//  MoviesAPI.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 18/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import Foundation
import Alamofire

class MoviesAPI {
    
    static private let basePath = "https://api.themoviedb.org/3";
    static private let chaveAPI = "dfefa0dcb9ee40d95a920753d6e62a44";
    
    class func loadMovies(page: Int = 1, onComplete: @escaping (MovieInfo?) -> Void){
        
        let url = self.basePath+"/movie/popular?page=\(page)&api_key=\(self.chaveAPI)"
        print(url)
        Alamofire.request(url).responseJSON { (response) in
            guard let data  = response.data,
                let moviesInfo = try? JSONDecoder().decode(MovieInfo.self, from: data) else {
                    onComplete(nil)
                    return
            }
            onComplete(moviesInfo)
                
        }
    }
}
