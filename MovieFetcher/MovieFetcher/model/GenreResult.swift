//
//  GenreResult.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 26/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

class GenreResult:Codable{
    var genres:[Genre]
    
    init(genres:[Genre]){
        self.genres = genres
    }
}
