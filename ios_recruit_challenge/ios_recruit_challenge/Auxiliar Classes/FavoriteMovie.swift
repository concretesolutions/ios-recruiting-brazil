//
//  FavoriteMovie.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 10/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import Foundation

class FavoriteMovie: NSObject, NSCoding {
    
    var movieTitle: String?
    var moviePosterUrl: String?
    var movieReleaseDate: String?
    var movieGenre:[String]?
    var movieApiIndex: String?
    

    init(movieTitle:String,moviePosterUrl:String,movieReleaseDate:String,movieGenre:[String], movieApiIndex:String){
        self.movieTitle = movieTitle
        self.moviePosterUrl = moviePosterUrl
        self.movieReleaseDate = movieReleaseDate
        self.movieGenre = movieGenre
        self.movieApiIndex = movieApiIndex
    }
    
    required init?(coder aDecoder: NSCoder) {
        movieTitle = aDecoder.decodeObject(forKey: "movieTitle") as? String
        moviePosterUrl = aDecoder.decodeObject(forKey: "moviePosterUrl") as? String
        movieReleaseDate = aDecoder.decodeObject(forKey: "movieReleaseDate") as? String
        movieGenre = aDecoder.decodeObject(forKey: "movieGenre") as? [String]
        movieApiIndex = aDecoder.decodeObject(forKey: "movieApiIndex") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(movieTitle, forKey: "movieTitle")
        aCoder.encode(moviePosterUrl, forKey: "moviePosterUrl")
        aCoder.encode(movieReleaseDate, forKey: "movieReleaseDate")
        aCoder.encode(movieGenre, forKey: "movieGenre")
        aCoder.encode(movieApiIndex, forKey: "movieApiIndex")
    }
    
}

