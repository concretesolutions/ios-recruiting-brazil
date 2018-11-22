//
//  Movie.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 22/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import Foundation

struct Movie: DataObject{
    var vote_count: Int
    var id: Double
    var video: Bool
    var vote_average: Float
    var popularity: Double
    var genre_ids: [Int]
    var title: String
    var poster_path: String
    var release_date: String
    var overview: String
    
    
}
