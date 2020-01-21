//
//  Movie.swift
//  Movs
//
//  Created by Rafael Douglas on 18/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

class Movie: Codable {
    var id: Int?
    var title: String?
    var overview: String?
    var vote_average: Float?
    var poster_path: String?
    
    var release_date: String?
    var genres: [Genre]?
    
}
