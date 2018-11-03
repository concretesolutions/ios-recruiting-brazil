//
//  FavoritesViewOutPut.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol FavoritesViewOutput: class {
    func display(movies: [FavoritesViewModel])
    func displayNoResults(for request: String)
    func displayError()
    
}
