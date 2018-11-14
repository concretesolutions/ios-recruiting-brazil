//
//  GetPopularMovies.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 12/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import Foundation

class GetPopularMovies: APIRequest {
    typealias Response = [Movie]
    
    var endpoint: String {
        return "movie/popular"
    }
    
    // Parameters
    let language: String?
    let page: Int?
    let region: String?
    
    init(language: String? = nil, page: Int? = nil, region: String? = nil) {
        self.language = language
        self.page = page
        self.region = region
    }
}
