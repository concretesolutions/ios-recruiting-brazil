//
//  Movie.swift
//  movs
//
//  Created by Lorien on 15/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit

struct Movie: Codable {
    
    let title: String!
    let overview: String
    let date: String
    let genreIds: [Int]
    let imagePath: String?
    
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case date = "release_date"
        case genreIds = "genre_ids"
        case imagePath = "poster_path"
    }
    
}
