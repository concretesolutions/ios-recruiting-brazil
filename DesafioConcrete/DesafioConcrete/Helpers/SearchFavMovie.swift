//
//  SearchFavMovie.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 08/12/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation
import UIKit

class SearchFavMovie{
    
    func search(text:String, favoriteMovies:[FavModel]) -> [FavModel]{
        var filteredMovies:[FavModel] = []
        
        for movie in favoriteMovies{
            
            if((movie.movieName?.contains(text))! || (movie.movieYear?.contains(text))! || (movie.movieDescription?.contains(text))!){
                
                filteredMovies.append(movie)
            }
        }
        
        return filteredMovies
    }
}
