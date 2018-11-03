//
//  MoviesGridViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MoviesGridViewPresenter: PresenterProtocol {
    func didSelectItem(at row:Int)
    func didFavoriteItem(at row:Int)
    func didUnfavoriteItem(at row:Int)
    func loadMoreMovies()
    func searchBarDidBeginEditing()
    func searchBarDidPressCancelButton()
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
    
    private var searchResultsViewController = MoviesSearchViewController()
    
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
        
        self.moviesGrid = MoviesGridView(frame: self.view.bounds)
        self.navigationItem.searchController = MovsNavigationSearchController(searchResultsController: self.searchResultsViewController)
        self.navigationItem.searchController?.searchResultsUpdater = self
        self.navigationItem.searchController?.delegate = self
        self.navigationItem.searchController?.searchBar.delegate = self
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        self.searchResultsViewController.didSelectorRowAt = { [unowned self] indexPath in
            self.presenter?.didSelectItem(at: indexPath.row)
        }
        
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
    
    func present(moreMovies:[Movie], startingAt row:Int) {
        self.moviesGrid.movieItems.append(contentsOf: moreMovies)
        self.moviesGrid.appendData(startingAt: row)
    }
    
    func present(searchResults: [Movie]) {
        self.searchResultsViewController.searchResults = searchResults
    }
    
    func presentError() {
        self.moviesGrid.state = .error
    }
    
    func presentEmptySearch() {
        self.moviesGrid.state = .emptySearch
    }
}

extension MoviesGridViewController: MoviesGridViewDelegate {
    
    func moviesGrid(_ sender: MoviesGridView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.didSelectItem(at: indexPath.row)
    }
    
    func moviesGrid(_ sender: MoviesGridView, didFavoriteItemAt indexPath: IndexPath) {
        self.presenter?.didFavoriteItem(at: indexPath.row)
    }
    
    func moviesGrid(_ sender: MoviesGridView, didUnfavoriteItemAt indexPath: IndexPath) {
        self.presenter?.didUnfavoriteItem(at: indexPath.row)
    }
    
    func moviewGrid(_ sender: MoviesGridView, didDisplayedCellAtLast indexPath: IndexPath) {
        self.presenter?.loadMoreMovies()
    }
}

extension MoviesGridViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.presenter?.searchBarDidBeginEditing()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter?.searchBarDidPressCancelButton()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.presenter?.updateSearchResults(searchText: searchController.searchBar.text)
    }
}
