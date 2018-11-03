//
//  Movie.swift
//  Movs
//
//  Created by Ricardo Rachaus on 26/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation
import CoreData

struct Movie: Decodable {
    var id: Int
    var genreIds: [Int]
    var posterPath: String
    var overview: String
    var releaseDate: String
    var title: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
    }
    
    /**
     Convert a NSManagedObject to a Movie object.
     
     - parameters:
         - managedObject: Object that stores a movie.
     
     - Returns: movie : [Movie]
     */
    static func movie(from managedObject: NSManagedObject) -> Movie {
        var movie = Movie(id: 0, genreIds: [], posterPath: "", overview: "", releaseDate: "", title: "")
        movie.id = managedObject.value(forKey: "id") as! Int
        movie.genreIds = managedObject.value(forKey: "genreIds") as! [Int]
        movie.posterPath = managedObject.value(forKey: "posterPath") as! String
        movie.overview = managedObject.value(forKey: "overview") as! String
        movie.releaseDate = managedObject.value(forKey: "releaseDate") as! String
        movie.title = managedObject.value(forKey: "title") as! String
        return movie
    }
}
