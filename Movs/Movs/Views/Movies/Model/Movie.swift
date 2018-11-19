//
//  Movie.swift
//  Movs
//
//  Created by Victor Rodrigues on 16/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import Foundation
import ObjectMapper

class Response: Mappable {
    
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [Movie]?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        page            <- map["page"]
        total_results   <- map["total_results"]
        total_pages     <- map["total_pages"]
        results         <- map["results"]
    }
    
}

class Movie: Mappable {
    
    var vote_count: Int?
    var id: Int?
    var video: Bool?
    var vote_average: Double?
    var title: String?
    var popularity: Int?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        vote_count          <- map["vote_count"]
        id                  <- map["id"]
        video               <- map["video"]
        vote_average        <- map["vote_average"]
        title               <- map["title"]
        popularity          <- map["popularity"]
        poster_path         <- map["poster_path"]
        original_language   <- map["original_language"]
        original_title      <- map["original_title"]
        genre_ids           <- map["genre_ids"]
        backdrop_path       <- map["backdrop_path"]
        adult               <- map["adult"]
        overview            <- map["overview"]
        release_date        <- map["release_date"]
    }
    
}
