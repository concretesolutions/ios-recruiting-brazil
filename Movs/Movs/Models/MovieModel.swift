//
//  MovieModel.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

fileprivate let JSON_TITLE_KEY = "original_title"
fileprivate let JSON_DESCRIPTION_KEY = "overview"
fileprivate let JSON_GENRES_IDS_KEY = "genre_ids"
fileprivate let JSON_ID_KEY = "id"
fileprivate let JSON_POSTER_KEY = "poster_path"
fileprivate let JSON_DATE_KEY = "release_date"

class MovieModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var year: String!
    @objc dynamic var sinopse: String!
    @objc dynamic var favority: Bool = false
    @objc dynamic var posterURl: String!
    @objc dynamic var id: Int = 0
    var genresIds: List<Int> = List<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.title = json[JSON_TITLE_KEY].stringValue
        self.sinopse = json[JSON_DESCRIPTION_KEY].stringValue
        self.id = json[JSON_ID_KEY].intValue
        self.genresIds.append(objectsIn: json[JSON_GENRES_IDS_KEY].arrayValue.map({$0.intValue}))
        
        self.posterURl = ""
        let posterPath = json[JSON_POSTER_KEY].stringValue
        if let posterSize = Settins.getPosterSize(), let baseURL = Settins.getBaseUrl(){
            self.posterURl = "\(baseURL)\(posterSize)\(posterPath)"
        }
        
        self.year = ""
        if let year = json[JSON_DATE_KEY].stringValue.split(separator: "-").first{
            self.year = String(year)
        }
    }
}
