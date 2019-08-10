//
//  FavoritesDetailsData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
struct FavoritesDetailsData {
    var id:Int
    var name:String
    var posterPath:String
    var year:Int
    var overView:String
    
    init(id:Int, name:String, posterPath:String, year:Int, overView:String) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.year = year
        self.overView = overView
    }
}
