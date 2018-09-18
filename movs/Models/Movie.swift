//
//  Movie.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let originalTitle: String
    let posterPath: String
    let genres: [Genre]
    let overview: String
    let releaseDate: String
    
    init(fromDictionary dictionary: NSDictionary) {
        self.id = dictionary["id"] as? Int ?? 0
        self.originalTitle = dictionary["original_title"] as? String ?? ""
        self.posterPath = dictionary["poster_path"] as? String ?? ""
        self.overview = dictionary["overview"] as? String ?? ""
        if let genresDictionary = dictionary["genres"] as? [NSDictionary] {
            self.genres = genresDictionary.map {
                return Genre(fromDictionary: $0)
            }
        } else {
            self.genres = []
        }
        self.releaseDate = dictionary["release_date"] as? String ?? ""
    }
}
