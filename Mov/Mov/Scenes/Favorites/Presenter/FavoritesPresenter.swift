//
//  FavoritesPresenter.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol FavoritesPresenter {
    func present(movies: [FavoritesUnit])
    
    func presentNoResultsFound(for request: String)
    
    func presentError()
}
