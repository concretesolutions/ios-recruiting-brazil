//
//  Movie.swift
//  Movs
//
//  Created by Filipe on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let id: Int
    let posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case id
        case posterImage = "poster_path"
    }
    
}
