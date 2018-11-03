//
//  MovieDetailPresentationLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieDetailPresentationLogic {
    /**
     Present movie details.
     
     - parameters:
         - response: Response of the movie details requested.
     */
    func present(response: MovieDetail.Response)
}
