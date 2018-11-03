//
//  TvShowMediaItem.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

struct TvShowMediaItem:MediaItem, Codable {
    
    let id: Int
    let evaluation: Float
    let title: String
    let poster: String?
    let overview: String
    let releaseDate: String
    var genres: Array<Int>
    let mediaType = MediaType.tv
    
    enum CodingKeys : String, CodingKey {
        case id
        case evaluation = "vote_average"
        case title = "name"
        case poster = "poster_path"
        case overview
        case releaseDate = "first_air_date"
        case genres = "genre_ids"
    }
    
    init(record:MediaItemDao){
        
        id = record.id
        evaluation = record.evaluation
        title = record.title
        poster = record.poster
        overview = record.overview
        releaseDate = record.releaseDate
        genres = record.getGenres()
        
    }
    
    func getThumbnailUrl() -> String {
        
        if let thumbFile = poster{
            return "https://image.tmdb.org/t/p/w200/\(thumbFile)"
        }else{
            return "noposter"
        }
        
    }
    
    func getPosterURL()->String{
        
        if let posterFile = poster{
            return "https://image.tmdb.org/t/p/w600_and_h900_bestv2/\(posterFile)"
        }else{
            return "noposter"
        }
        
    }
    
    func getYear()->String{
        
        let dateElements = releaseDate.components(separatedBy: "-")
        
        if let year = dateElements.first{
            return year
        }else{
            return "unknown"
        }
        
    }
    
}
