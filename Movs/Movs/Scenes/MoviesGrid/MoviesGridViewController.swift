//
//  MoviesGridViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MoviesGridViewPresenter: PresenterProtocol {
    func updateSearchResults(searchText:String?)
}

final class MoviesGridViewController: MVPBaseViewController {
    
    private var moviesGrid: MoviesGridView! {
        didSet {
            self.moviesGrid.setupView()
            self.moviesGrid.delegate = self
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

extension MoviesGridViewController: MoviesGridViewDelegate {
    
    func moviesGrid(_ sender: MoviesGridView, didSelectItemAt indexPath: IndexPath) {
        print("select:\(indexPath.row)")
    }
    
    func moviesGrid(_ sender: MoviesGridView, didFavoriteItemAt indexPath: IndexPath) {
        print("favorite:\(indexPath.row)")
    }
    
    func moviesGrid(_ sender: MoviesGridView, didUnfavoriteItemAt indexPath: IndexPath) {
        print("unfavorite:\(indexPath.row)")
    }
}

extension MoviesGridViewController: MoviesGridPresenterView {
    
    func setupOnce() {
        self.title = "Movies"
        self.moviesGrid = MoviesGridView(frame: self.view.bounds)
        self.navigationItem.searchController = MovsNavigationSearchController(searchResultsController: nil)
        self.navigationItem.searchController?.searchResultsUpdater = self
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.definesPresentationContext = true
    }
    
    func presentLoading() {
        self.moviesGrid.state = .loading
    }
    
    func present(movies: [Movie]) {
        self.moviesGrid.movieItems = movies
        self.moviesGrid.state = .grid
        self.moviesGrid.reloadData()
    }
    
    func presentError() {
        self.moviesGrid.state = .error
    }
    
    func presentEmptySearch() {
        self.moviesGrid.state = .emptySearch
    }
}

extension MoviesGridViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.presenter?.updateSearchResults(searchText: searchController.searchBar.text)
    }
}
