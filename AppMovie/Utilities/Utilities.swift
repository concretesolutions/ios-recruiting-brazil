//
//  Utilities.swift
//  AppMovie
//
//  Created by Renan Alves on 28/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

struct Index {
    
    static func getIndexInArray(movie: MovieNowPlaying,at array: [MovieNowPlaying]) -> Int {
        for (index, _movie) in array.enumerated() {
            let _id = _movie.id
            let id = movie.id
            if  _id == id {
                return index
            }
        }
        return -1
    }
}
