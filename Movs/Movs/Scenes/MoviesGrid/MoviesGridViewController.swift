//
//  MoviesGridViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MoviesGridViewPresenter: PresenterProtocol {
}

final class MoviesGridViewController: MVPBaseViewController, MoviesGridPresenterView {
    
    private let moviesGridDataSource = MoviesGridDataSource()
    private var moviesGrid: MoviesGrid! {
        didSet {
            self.view = self.moviesGrid
        }
    }
    
    var presenter: MoviesGridViewPresenter? {
        get {
            return self.basePresenter as? MoviesGridViewPresenter
        }
        set {
            self.basePresenter = newValue
        }
    }
    
    func setupOnce() {
        self.title = "Movies"
        self.moviesGrid = MoviesGrid(frame: self.view.bounds)
        self.moviesGrid.setup()
    }
}
