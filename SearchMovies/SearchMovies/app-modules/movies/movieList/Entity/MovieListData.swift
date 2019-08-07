//
//  MovieListData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct MovieListData {
    var id:Int
    var name:String
    var isFavorite:Bool
    
    init(id:Int, name:String, isFavorite:Bool) {
        self.id = id
        self.name = name
        self.isFavorite = isFavorite
    }
}
