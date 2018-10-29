//
//  Utilities.swift
//  AppMovie
//
//  Created by Renan Alves on 28/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

struct Index {
    
    func getIndexInArray(movie: Movie,at array: [Movie]) -> Int {
        for (index, _movie) in array.enumerated() {
            let _id = _movie.movie?.id
            let id = movie.movie?.id
            if  _id == id {
                return index
            }
        }
        return -1
    }
}
