//
//  MovieDetailWorkingLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

protocol MovieDetailWorkingLogic {
    /**
     Fetch movie details.
     
     - parameters:
         - movie: Movie to request details.
         - completion: Action to be made after fetch is completed.
     */
    func fetch(movie: Movie, completion: @escaping (MovieDetailed?, UIImageView?, Error?) -> ())
}
