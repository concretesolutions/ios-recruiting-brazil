//
//  MediaItem.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

struct MediaItem:Codable {
    
    var title:String
    var year:String
    var imdbID:String
    var poster:String
    
    enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
    
}
