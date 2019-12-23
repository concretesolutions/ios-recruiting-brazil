//
//  MovieView.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// A protocol to be implemmented by all views that shows movies(the cells)
protocol MovieView: UIView {
    
    var viewModel: MovieViewModel? { get set }
}
