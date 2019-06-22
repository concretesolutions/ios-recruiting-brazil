//
//  GenresResponse.swift
//  Movs
//
//  Created by Filipe Merli on 21/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [Genres]
    
    enum CodingKeys: String, CodingKey {

        case genres
    }
}
