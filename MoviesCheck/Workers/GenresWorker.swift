//
//  GenresWorker.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

class GenresWorker{
    
    class func getGenresDescription(validGenres:Array<Int>, genresList:GenreResult)->String{
        
        var description = "";
        
        var count = 0;
        for genre in genresList.genres{
            
            if(validGenres.contains(genre.id)){
                
                count += 1
                description.append(genre.name)
                
                if(count < validGenres.count){
                    description.append(", ")
                }
                
            }
            
        }
        
        return description
        
    }
    
}
