//
//  Movie.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieResult: Mappable {
    
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [Movie]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.page <- map["page"]
        self.total_results <- map["total_results"]
        self.total_pages <- map["total_pages"]
        self.results <- map["results"]
    }
    
}

class Movie: Mappable {
    
    var title: String?
    var isFavourite: Bool?
    var poster_path: String?
    var id: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.title <- map["title"]
        self.poster_path <- map["poster_path"]
        self.id <- map["id"]
    }
    
}
