//
//  RLMMovieModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RealmSwift

class RLMMovieModel: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var posterPath: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var releaseYear: String = ""
    var genders = List<RLMGenderModel>()
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
