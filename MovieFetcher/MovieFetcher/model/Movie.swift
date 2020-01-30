//
//  Movie.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 23/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

class Movie:Codable{
    
    let poster_path:String!
    let overview:String!
    let release_date:String!
    let id:Int!
    let genre_ids:[Int]!
    let original_title:String!
    let original_language:String!
    let title:String!
    let backdrop_path:String!
    let popularity:Float!
    let vote_count:Int!
    let video:Bool!
    let vote_average:Float!
    var isFavorite:Bool?
    var listIndexPath:IndexPath?
    
    init(poster_path:String,overview:String,release_date:String,id:Int,genre_ids:[Int],original_title:String,original_language:String,title:String,backdrop_path:String,popularity:Float,vote_count:Int,video:Bool,vote_average:Float,isFavorite:Bool) {
        
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
        self.id = id
        self.genre_ids = genre_ids
        self.original_title = original_title
        self.original_language = original_language
        self.title = title
        self.backdrop_path = backdrop_path
        self.popularity = popularity
        self.vote_count = vote_count
        self.video = video
        self.vote_average = vote_average
        self.isFavorite = false
    }
    
}

