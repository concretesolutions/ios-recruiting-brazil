//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol FavoriteMoveisViewPresenter: PresenterProtocol {
}

final class FavoriteMoviesViewController: MVPBaseViewController {
    
    private var favoriteMovies:FavoriteMovies! {
        didSet {
            self.favoriteMovies.setupView()
            self.view = self.favoriteMovies
        }
    }
    
    var presenter:FavoriteMoveisViewPresenter? {
        get {
            return self.basePresenter as? FavoriteMoveisViewPresenter
        }
        set {
            self.basePresenter = newValue
        }
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesPresenterView {
    
    func setupOnce() {
        self.title = "Favorites"
        self.favoriteMovies = FavoriteMovies()
        self.navigationItem.searchController = MovsNavigationSearchController(searchResultsController: nil)
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.definesPresentationContext = true
    }
}
