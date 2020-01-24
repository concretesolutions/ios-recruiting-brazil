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
    let releaseDate:Date!
    let id:Int!
    let genre_ids:[Int]!
    let original_title:String!
    let original_language:String!
    let title:String!
    let backdrop_path:String!
    let popularity:Float!
    let voteCount:Int!
    let video:Bool!
    let vote_average:Float!
    var isFavorite:Bool?
    
    init(poster_path:String,overview:String,releaseDate:Date,id:Int,genre_ids:[Int],original_title:String,original_language:String,title:String,backdrop_path:String,popularity:Float,voteCount:Int,video:Bool,vote_average:Float,isFavorite:Bool) {
        
        self.poster_path = poster_path
        self.overview = overview
        self.releaseDate = releaseDate
        self.id = id
        self.genre_ids = genre_ids
        self.original_title = original_title
        self.original_language = original_language
        self.title = title
        self.backdrop_path = backdrop_path
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.vote_average = vote_average
        self.isFavorite = false
    }
    
}

/*
{
  "poster_path": "/IfB9hy4JH1eH6HEfIgIGORXi5h.jpg",
  "adult": false,
  "overview": "Jack Reacher must uncover the truth behind a major government conspiracy in order to clear his name. On the run as a fugitive from the law, Reacher uncovers a potential secret from his past that could change his life forever.",
  "release_date": "2016-10-19",
  "genre_ids": [
    53,
    28,
    80,
    18,
    9648
  ],
  "id": 343611,
  "original_title": "Jack Reacher: Never Go Back",
  "original_language": "en",
  "title": "Jack Reacher: Never Go Back",
  "backdrop_path": "/4ynQYtSEuU5hyipcGkfD6ncwtwz.jpg",
  "popularity": 26.818468,
  "vote_count": 201,
  "video": false,
  "vote_average": 4.19
}
*/
