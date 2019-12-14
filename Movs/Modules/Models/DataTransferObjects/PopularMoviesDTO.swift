//
//  PopularMoviesDTO.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

struct PopularMoviesDTO: Decodable, Equatable {
    
    // MARK: - Attributes
    
    let page: Int
    let results: [MovieDTO]
    
}
