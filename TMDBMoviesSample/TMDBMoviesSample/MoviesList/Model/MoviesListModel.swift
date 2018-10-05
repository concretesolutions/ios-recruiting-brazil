//
//  MoviesListModel.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MoviesListModel: Decodable {
    
    var moviesList: [MovieModel] = []
    var page: Int = 0
    var totalPages: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case moviesList = "results"
        case page
        case totalPages = "total_pages"
    }
}
