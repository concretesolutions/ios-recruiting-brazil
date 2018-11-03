//
//  MovieGridViewOutput.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


protocol MovieGridViewOutput: class {
    
    func display(movies: [MovieGridViewModel])
    
    func displayNetworkError()
    
    func displayNoResults(for request: String)
    
    func displayFavoritesError()
    
}
