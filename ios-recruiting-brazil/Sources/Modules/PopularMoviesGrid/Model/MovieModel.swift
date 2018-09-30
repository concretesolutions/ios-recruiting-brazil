//
//  MovieModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper

struct MovieModel: Mappable {
    var id: Int
    var posterPath: String
    var title: String
    var isFavorite: Bool = false
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try posterPath = map.from("poster_path")
        try title = map.from("original_title")
    }
}
