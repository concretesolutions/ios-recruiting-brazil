//
//  MovieInteractor.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol MovieInteractor {
    func toggleFavoriteMovie(at index: Int)
    
    func filterMoviesBy(string: String)
}
