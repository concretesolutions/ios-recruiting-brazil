//
//  RM_Movie.swift
//  RMovie
//
//  Created by Renato Mori on 03/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import Foundation

class RM_Movie{
    var adult : Bool?;
    var backdrop_path :String?;
    var genre_ids : [NSInteger?];
    var id : NSInteger?;
    var original_language : String?;
    var original_title : String?;
    var overview : String?;
    var popularity : Double?;
    var poster_path : String?;
    var release_date : String?;
    var title : String?;
    var video : Bool?;
    var vote_average : Double?;
    var vote_count : NSInteger?;
    
    init(JSON : NSDictionary){
        print(JSON)
        self.adult = (JSON.value(forKey: "adult") != nil && JSON.value(forKey: "adult") as! NSInteger == 1)
        self.backdrop_path = JSON.value(forKey: "backdrop_path") as? String
        self.genre_ids = JSON.value(forKey: "genre_ids") as! [NSInteger?]
        self.id = JSON.value(forKey: "id") as? NSInteger
        self.original_language = JSON.value(forKey: "original_language") as? String
        self.original_title = JSON.value(forKey: "original_title") as? String
        self.overview = JSON.value(forKey: "overview") as? String
        self.popularity = JSON.value(forKey: "popularity") as? Double
        self.poster_path = JSON.value(forKey: "poster_path") as? String
        self.release_date = JSON.value(forKey: "release_date") as? String
        self.title = JSON.value(forKey: "title") as? String
        self.video = JSON.value(forKey: "video") != nil && JSON.value(forKey: "video") as! NSInteger == 1
        self.vote_average = JSON.value(forKey: "vote_average") as? Double
        self.vote_count = JSON.value(forKey: "vote_count") as? NSInteger
    }
    
}
