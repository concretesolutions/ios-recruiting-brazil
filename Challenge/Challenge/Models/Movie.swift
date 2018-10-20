//
//  Movie.swift
//  Challenge
//
//  Created by Sávio Berdine on 20/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    
    var image: UIImage?
    var name: String?
    var isFavourite: Bool?
    var year: Int?
    var genre: String?
    var description: String?
    var id: String?
    
    init(image: UIImage, name: String, isFavourite: Bool, year: Int, genre: String, description: String, id: String) {
        self.image = image
        self.name = name
        self.isFavourite = isFavourite
        self.year = year
        self.genre = genre
        self.description = description
        self.id = id
    }
    
//    func getPopularMovies() -> [Movie] {
//
//    }
//
//    func getFavouriteMovies() -> [Movie] {
//
//    }
    
}
