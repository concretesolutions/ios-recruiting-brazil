//
//  MovieDetailWorkingLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

protocol MovieDetailWorkingLogic {
    func fetch(movie: Movie, completion: @escaping (MovieDetailed?, UIImageView?, Error?) -> ())
}
