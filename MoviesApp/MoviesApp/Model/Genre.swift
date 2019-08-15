//
//  Genre.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


//A single genre
class Genre: Codable{
    var id: Int
    var name: String
}

//All genres in the API
class Genres: Codable{
    var genres: [Genre]
}

