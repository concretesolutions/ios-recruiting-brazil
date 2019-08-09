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
    var moviesTotal:Int
    
    init(pageNumber:Int, movies:[MovieListData], moviesTotal:Int) {
        self.pageNumber = pageNumber
        self.movies = movies
        self.moviesTotal = moviesTotal
    }
}


extension MovieListResult : Decodable {

    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case movies = "results"
        case moviesTotal = "total_results"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let pageDecodable = try container.decode(Int.self, forKey: .pageNumber)
        let moviesDecodable = try container.decode([MovieListData].self, forKey: .movies)
        let totalDecodable = try container.decode(Int.self, forKey: .moviesTotal)
        self.init(pageNumber: pageDecodable, movies: moviesDecodable, moviesTotal: totalDecodable)
    }
    
}
