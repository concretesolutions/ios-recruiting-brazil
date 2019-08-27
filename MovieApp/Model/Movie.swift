//
//  Movie.swift
//  MovieApp
//
//  Created by Mac Pro on 27/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation

class Movie: Codable{
    
    var voteCount: Int
    var idMovie: Int
    var voteAverage: Float
    var title: String
    var popularity: Float
    var posterPath: String
    var genreIds: [Int]
    var backdropPath: String
    var adult: Bool
    var overview: String
    
    init(voteCount: Int,idMovie: Int,voteAverage: Float,title: String,popularity:Float,posterPath:String,genreIds:[Int],backdropPath:String,adult:Bool,overview:String) {
        
        self.voteCount = voteCount
        self.idMovie = idMovie
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.genreIds = genreIds
        self.backdropPath = backdropPath
        self.adult = adult
        self.overview = overview
    }
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case idMovie = "id"
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
    }
    
}
