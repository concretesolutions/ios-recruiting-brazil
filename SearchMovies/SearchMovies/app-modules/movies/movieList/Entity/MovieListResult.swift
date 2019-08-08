//
//  MovieListResult.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct MovieListResult {
    var pageNumber:Int
    var movies:[MovieListData]
    
    init(pageNumber:Int, movies:[MovieListData]) {
        self.pageNumber = pageNumber
        self.movies = movies
    }
}


extension MovieListResult : Decodable {

    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case movies = "results"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let pageDecodable = try container.decode(Int.self, forKey: .pageNumber)
        let moviesDecodable = try container.decode([MovieListData].self, forKey: .movies)
        self.init(pageNumber: pageDecodable, movies: moviesDecodable)
    }
    
}
