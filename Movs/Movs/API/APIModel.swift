//
//  APIModel.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    
    let id:Int
    let title:String
    let posterPath:String
    var isFavorite:Bool = false
    
    var w92PosterPath:String {
        return self.posterCompletePath(sizeClass: "w92")
    }
    
    func posterCompletePath(sizeClass:String) -> String {
        return "\(API.imageLink)/\(sizeClass)\(self.posterPath)"
    }
    
    init(id:Int, title:String, posterPath:String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

public struct MovieDetail: Codable {
    
    let id:Int
    let title:String
    let posterPath:String
    let releaseDate:String
    let genres:[Genre]
    let overview:String
    var isFavorite:Bool = false
    
    var releaseYear:String {
        return String(self.releaseDate.prefix(4))
    }
    
    var genreNames:String {
        var str = ""
        self.genres.forEach { genre in
            str.append("\(genre.name), ")
        }
        return str
    }
    
    var w185PosterPath:String {
        return self.posterCompletePath(sizeClass: "w185")
    }
    
    var isComplete:Bool {
        return !(self.releaseDate.isEmpty || self.overview.isEmpty)
    }
    
    init(id:Int, title:String, posterPath:String, releaseDate:String, genres:[Genre], overview:String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.genres = genres
        self.overview = overview
    }
    
    func posterCompletePath(sizeClass:String) -> String {
        return "\(API.imageLink)/\(sizeClass)\(self.posterPath)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genres
        case overview
    }
}

public struct Genre: Codable {
    let id:Int
    let name:String
    init(id:Int, name:String) {
        self.id = id
        self.name = name
    }
}
