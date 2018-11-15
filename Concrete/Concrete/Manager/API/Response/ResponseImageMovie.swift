//
//  ResponseImageMovie.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 15/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import Foundation

struct ResponseImageMovie: Decodable {
    
    let id:Int
    let backdrops:Data
    let posters:Data
    
}
