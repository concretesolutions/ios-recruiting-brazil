//
//  MovieDetailDisplayLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieDetailDisplayLogic: class {
    /**
     Display movie details.
     
     - parameters:
         - viewModel: Data of the movie to be displayed.
     */
    func display(viewModel: MovieDetail.ViewModel)
}
