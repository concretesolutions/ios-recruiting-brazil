//
//  MovieDetailsInteractor.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


protocol MovieDetaisInteractor {
    func getDetails(of movie: Movie)
    func toggleFavorite(_ movie: Movie)
}
