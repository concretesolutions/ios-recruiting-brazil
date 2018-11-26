//
//  GetSearchMovies.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 14/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import Foundation

class GetSearchMovies: APIRequest {
    typealias Response = ResponseMovies
    
    var endpoint: String {
        return "search/movie"
    }
    
    // Parameters
    let query: String?
    let language: String?
    let page: Int?
    let includeAdult: Bool
    let region: String?
    let year: Int?
    let primaryReleaseYear: Int?
    
    init(query: String? = nil, language: String? = nil, page: Int? = nil, includeAdult: Bool = false, region: String? = nil, year: Int? = nil, primaryReleaseYear: Int? = nil) {
        self.query = query
        self.language = language
        self.page = page
        self.includeAdult = includeAdult
        self.region = region
        self.year = year
        self.primaryReleaseYear = primaryReleaseYear
    }
}
