//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol FavoriteMoviesViewPresenter: PresenterProtocol {
}

final class FavoriteMoviesViewController: MVPBaseViewController {
    
    private var favoriteMoviesView:FavoriteMoviesView! {
        didSet {
            self.favoriteMoviesView.setupView()
            self.view = self.favoriteMoviesView
        }
    }
    
    var presenter:FavoriteMoviesViewPresenter? {
        get {
            return self.basePresenter as? FavoriteMoviesViewPresenter
        }
        set {
            self.basePresenter = newValue
        }
    }
    
    private func showFilterBarButtonIfAppropriated() {
        if self.favoriteMoviesView.state != .empty {
            self.showFilterBarButtonItem()
        } else {
            self.hideFilterBarButtonItem()
        }
    }
    
    private func showFilterBarButtonItem() {
        if self.navigationItem.rightBarButtonItem == nil {
            let item = UIBarButtonItem(image: Assets.filterIcon.image, style: .plain, target: self, action: #selector(filterBarButtonItemSelector))
            self.navigationItem.rightBarButtonItem = item
        }
    }
    
    private func hideFilterBarButtonItem() {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc private func filterBarButtonItemSelector() {
        //TODO: call presenter
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesPresenterView {
    
    func setupOnce() {
        self.title = "Favorites"
        self.favoriteMoviesView = FavoriteMoviesView()
//        self.navigationItem.searchController = MovsNavigationSearchController(searchResultsController: nil)
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//        self.navigationItem.largeTitleDisplayMode = .automatic
//        self.definesPresentationContext = true
    }
    
    func setupWhenAppear() {
        self.showFilterBarButtonIfAppropriated()
    }
    
    func present(favoriteMovies: [MovieDetail]) {
        self.favoriteMoviesView.state = .all
        self.favoriteMoviesView.movieItems = favoriteMovies
    }
    
    func present(filteredMovies: [MovieDetail]) {
        self.favoriteMoviesView.state = .filtered
        self.favoriteMoviesView.movieItems = filteredMovies
    }
    
    func presentEmpty() {
        self.favoriteMoviesView.state = .empty
    }
}
