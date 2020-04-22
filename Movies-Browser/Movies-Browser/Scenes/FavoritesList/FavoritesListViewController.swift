//
//  FavoritesListViewController.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {
    // MARK: - Variables
    weak var coordinator: FavoritesListCoordinator?
    weak var viewModel: FavoritesListViewModel?
    
    // MARK - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
}

// MARK: - Events -
extension FavoritesListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupViewModelListener()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarTitle()
        viewModel?.viewWillAppear()
    }
}

// MARK: - Navigation Bar Title -
extension FavoritesListViewController {
    private func setNavigationBarTitle(){
        coordinator?.tabBarController?.navigationItem.title = "Favorites"
    }
}

// MARK: - TableView Setup -
extension FavoritesListViewController {
    func setupTableView(){
        tableView.registerCellForType(.favoriteCell)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - TableView Delegate & DataSource {
extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.state.favoriteMovies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movies = viewModel?.state.favoriteMovies, movies.count > indexPath.row else { return UITableViewCell() }
            
        let movie = movies[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.favoriteCell.rawValue) as? FavoriteTableViewCell {
            cell.setup(posterPath: movie.posterPath, title: movie.title, year: movie.releaseDate.year, overview: movie.overview)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.movieWasTapped(id: indexPath.row)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.unfavoriteButtonWasTapped(indexPath: indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
}

// MARK: - SearchBar Setup -
extension FavoritesListViewController: UISearchBarDelegate {
    func setupSearchBar(){
        searchBar.isHidden = true
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search for a movie (ex: Inception)"
    }
    
    func enableSearchBar(){
        DispatchQueue.main.async { [weak self] in
            self?.searchBar.isHidden = false
        }
    }
    
    func disableSearchBar(){
        DispatchQueue.main.async { [weak self] in
            self?.searchBar.isHidden = true
        }
    }
    
    func unfocusSearchBar(){
        DispatchQueue.main.async { [weak self] in
            self?.searchBar.resignFirstResponder()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        unfocusSearchBar()
        if let searchText = searchBar.text, !searchText.isEmpty {
            viewModel?.searchButtonWasTapped(searchText: searchText)
        } else {
            viewModel?.searchWasCleared()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel?.searchWasCleared()
        }
    }
}

// MARK: - ViewModel -
extension FavoritesListViewController {
    func setupViewModelListener(){
        viewModel?.callback = { [weak self] state in
            
            if state.presentEmptyFavorites {
                self?.presentEmptyFavorites()
                self?.disableSearchBar()
            } else if state.presentEmptySearch {
                self?.presentEmptySearch(searchText: state.searchText)
            } else {
                self?.clearBackgroundView()
            }
            
            if !state.favoriteMovies.isEmpty {
                self?.enableSearchBar()
            }
            
            if state.refreshFavoriteMovies {
                self?.refreshFavoriteMovies()
            }
            
            if state.searchText.isEmpty {
                self?.unfocusSearchBar()
            }
            
            if let unwrappedMovie = state.selectedMovie, state.presentSelectedMovie {
                self?.selectedMovieDidChange(movie: unwrappedMovie)
            }
        }
    }
}

// MARK: - State UI Updates -
extension FavoritesListViewController {
    func refreshFavoriteMovies(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel?.favoriteMoviesDidRefresh()
    }
    func selectedMovieDidChange(movie: Movie) {
        coordinator?.startMovieDetail(movie: movie)
        viewModel?.selectedMovieDetailDidPresent()
    }
    func clearBackgroundView(){
        DispatchQueue.main.async { [weak self] in guard let self = self else { return }
            self.tableView.backgroundView = UIView()
        }
    }
    func presentEmptyFavorites(){
        DispatchQueue.main.async { [weak self] in guard let self = self else { return }
            let frame = self.tableView.backgroundView?.frame ?? self.view.frame
            self.tableView.backgroundView = EmptyFavoriteView.instantiate(frame: frame, emoji: "🥺", message: "Don't be so shy! Choose a favorite movie.")
        }
    }
    func presentEmptySearch(searchText: String){
        DispatchQueue.main.async { [weak self] in guard let self = self else { return }
            let frame = self.tableView.backgroundView?.frame ?? self.view.frame
            self.tableView.backgroundView = EmptySearchView.instantiate(frame: frame, emoji: "🧐", message: "No match for the search term \"\(searchText)\" has been found.")
        }
    }
}
