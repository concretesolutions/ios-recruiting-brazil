//
//  Movie.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Foundation

struct Movie:Decodable{
    
    var id:Int?
    var title:String?
    var releaseDate:String?
    private var url:String?
    
    var poster: String? {
        get{
            if let url = url{
                return "https://image.tmdb.org/t/p/w500/\(url)"
            }
            return nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id          = "id"
        case title       = "title"
        case url         = "poster_path"
        case releaseDate = "release_date"
    }
}
