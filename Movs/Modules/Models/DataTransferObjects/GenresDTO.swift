//
//  GenresDTO.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

struct GenresDTO: Decodable, Equatable {
    
    // MARK: - Attributes
    
    let genres: [GenreDTO]
    
}
