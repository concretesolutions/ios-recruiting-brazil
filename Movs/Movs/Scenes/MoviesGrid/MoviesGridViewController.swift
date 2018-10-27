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

final class MoviesGridViewController: MVPBaseViewController {
    
    private var moviesGrid: MoviesGrid! {
        didSet {
            self.moviesGrid.setupView()
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
}

extension MoviesGridViewController: MoviesGridPresenterView {
    
    func setupOnce() {
        self.title = "Movies"
        self.moviesGrid = MoviesGrid(frame: self.view.bounds)
        self.navigationItem.searchController = MovsNavigationSearchController(searchResultsController: nil)
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.definesPresentationContext = true
    }
}
