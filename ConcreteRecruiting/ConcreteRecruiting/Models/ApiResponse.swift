//
//  ApiResponse.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

struct MovieApiResponse: Decodable {
    
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
    
}
