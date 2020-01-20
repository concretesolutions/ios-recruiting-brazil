//
//  FavoriteMoviesViewController.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 17/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    var favoriteView: FavoriteMoviesView {
        return self.view as! FavoriteMoviesView
    }
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private var favoriteMovies: [Movie] = []
    
    private var isDeletingWithCommit: Bool = false
    
    private let movieDetailsVC = MovieDetailsViewController()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchText: String = ""
    private var filteredMovies: [Movie] = []
    private var isFiltering: Bool {
      return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    // Private Methods
    
    private func initController() {
        self.view = FavoriteMoviesView()
        
        self.updateMovieArrays()
        
        movieDetailsVC.setCustomNavigationBar(title: "Movie Details", color: .mvText)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
        favoriteView.tableView.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: FavoriteMovieTableViewCell.reuseIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateFavoriteInformation), name: Movie.favoriteInformationDidChangeNN, object: nil)
    }
    
    private func updateMovieArrays() {
        self.favoriteMovies = TmdbAPI.movies.filter({$0.isFavorite}).sorted(by: {$0.title < $1.title})
        self.filteredMovies = self.filteredMovies.filter({$0.isFavorite})
    }
    
    @objc private func didUpdateFavoriteInformation() {
        if !self.isDeletingWithCommit {
            DispatchQueue.main.async {
                self.updateMovieArrays()
                self.favoriteView.tableView.reloadData()
            }
        }
    }
    
    private func filterLocalMovies(for searchText: String) {
        self.filteredMovies = self.favoriteMovies.filter({ (movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }).sorted(by: { (a, b) -> Bool in
            if a.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                if b.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                    return a.title.lowercased() < b.title.lowercased()
                }
                else {
                    return true
                }
            }
            else if b.title.prefix(searchText.count).lowercased() == searchText.lowercased() {
                return false
            }
            else {
                return a.title.lowercased() < b.title.lowercased()
            }
        })
        
        DispatchQueue.main.async {
            self.favoriteView.tableView.reloadData()
        }
    }
}

// MARK: - TableView Delegate
extension FavoriteMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering {
            if filteredMovies.count == 0 {
                self.favoriteView.emptySearchView.searchText = self.searchText
                self.favoriteView.emptySearchView.isHidden = false
            }
            else {
                self.favoriteView.emptySearchView.isHidden = true
            }
            
            return filteredMovies.count
        }
        else {
            self.favoriteView.emptySearchView.isHidden = true
            self.favoriteView.emptyFavoriteView.isHidden = !self.favoriteMovies.isEmpty
            return self.favoriteMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.reuseIdentifier) as! FavoriteMovieTableViewCell
        
        let movie = self.isFiltering ? self.filteredMovies[indexPath.row] : self.favoriteMovies[indexPath.row]
        cell.fill(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoriteMovieTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            self.isDeletingWithCommit = true
            
            let movie = self.isFiltering ? self.filteredMovies[indexPath.row] : self.favoriteMovies[indexPath.row]
            movie.isFavorite = false
            
            DispatchQueue.main.async {
                self.updateMovieArrays()
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            self.isDeletingWithCommit = false
        }

        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.favoriteMovies[indexPath.row]
        movieDetailsVC.movie = movie
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

// MARK: - Search Controller Update
extension FavoriteMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            searchText = text
            filterLocalMovies(for: text)
        }
        else {
            DispatchQueue.main.async {
                self.updateMovieArrays()
                self.favoriteView.tableView.reloadData()
            }
        }
    }
}
