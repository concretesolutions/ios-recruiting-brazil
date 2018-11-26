//
//  GetGenres.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 14/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import Foundation

class GetGenres: APIRequest {
    typealias Response = ResponseGenre
    
    var endpoint: String {
        return "genre/movie/list"
    }
    
    // Parameters
    let language: String?
    
    init(language: String? = nil) {
        self.language = language
    }
}

