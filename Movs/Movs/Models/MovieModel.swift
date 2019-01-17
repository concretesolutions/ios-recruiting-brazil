//
//  MovieModel.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation
import SwiftyJSON

fileprivate let JSON_TITLE_KEY = "original_title"
fileprivate let JSON_DESCRIPTION_KEY = "overview"
fileprivate let JSON_GENRES_IDS_KEY = "genre_ids"
fileprivate let JSON_ID_KEY = "id"
fileprivate let JSON_POSTER_KEY = "poster_path"
fileprivate let JSON_DATE_KEY = "release_date"

class MovieModel {
    var title: String
    var year: String
    var genresIds: [Int]
    var description: String
    var favority: Bool
    var posterURl: String
    var id: Int
    
    init(json: JSON) {
        self.favority = false
        self.title = json[JSON_TITLE_KEY].stringValue
        self.description = json[JSON_DESCRIPTION_KEY].stringValue
        self.genresIds = json[JSON_GENRES_IDS_KEY].arrayValue.map({$0.intValue})
        self.id = json[JSON_ID_KEY].intValue
        
        let posterPath = json[JSON_POSTER_KEY].stringValue
        
        self.posterURl = ""
        if let posterSize = Settins.getPosterSize(), let baseURL = Settins.getBaseUrl(){
            self.posterURl = "\(baseURL)\(posterSize)\(posterPath)"
        }
        
        self.year = ""
        if let year = json[JSON_DATE_KEY].stringValue.split(separator: "-").first{
            self.year = String(year)
        }
    }
}
