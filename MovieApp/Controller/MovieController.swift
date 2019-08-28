//
//  MovieController.swift
//  MovieApp
//
//  Created by Mac Pro on 27/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation

class MovieController{
    
    var movieAPI = MovieAPI()
    
    var arrayMovieDB: [Movie] = []
    
    
    func getMoviesAPI(completion: @escaping (Bool)-> Void){
    
        movieAPI.getMoviesDB { (moviesDB, error) in
            if error != nil{
                completion(false)
                print("Deu ruim")
            }else{
                self.arrayMovieDB = moviesDB?.results ?? []
                completion(true)
            }
        }
        
    }
    
    
}
