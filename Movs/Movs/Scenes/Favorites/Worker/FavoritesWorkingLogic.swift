//
//  FavoritesWorkingLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

protocol FavoritesWorkingLogic {
    /**
     Fetch movie poster.
     
     - parameters:
         - posterPath: Path to the poster.
     
     - Returns: posterImageView : UIImageView
     */
    func fetchPoster(posterPath: String) -> UIImageView
}
