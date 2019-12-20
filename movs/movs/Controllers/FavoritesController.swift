//
//  FavoritesController.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    // MARK: - Navigation item
    lazy var filterButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goToFilters))
        
        return item
    }()
    
    // MARK: - Attributes
    lazy var screen = FavoritesScreen(controller: self)
    let dataService = DataService.shared
    var searchFilteredBy = ""
    var filters: [FilterType: String] = [:]
    var favorites: [Movie] = [] {
        didSet {
            self.favorites.sort { (lmovie, rmovie) -> Bool in
                return lmovie.title < rmovie.title
            }
        }
    }
    
    // MARK: - Collection state
    var collectionState: CollectionState = .loading {
        didSet {
            switch self.collectionState {
            case .loading:
                self.dataService.loadFavorites { (state) in
                    // Set state according to filter existence and load result
                    if state == .loadSuccess && !(self.filters.isEmpty && self.searchFilteredBy.isEmpty) {
                        self.collectionState = .filtered
                    } else {
                        self.collectionState = state
                        self.screen.hideButton()
                    }
                }
            case .loadSuccess:
                self.favorites = self.dataService.favorites
            case .loadError:
                self.screen.showErrorView()
            case .normal:
                self.screen.presentEmptySearch(false)
                self.favorites = self.dataService.favorites
            case .filtered:
                self.favorites = self.dataService.favorites.filter({ (movie) -> Bool in
                    // Movie match status
                    var isMatching = true
                    
                    // Apply filters
                    self.filters.forEach { (key, value) in
                        if isMatching == true {
                            isMatching = movie.has(value, for: key)
                        }
                    }
                    
                    // Apply search
                    if !self.searchFilteredBy.isEmpty && isMatching == true {
                        isMatching = movie.title.lowercased().contains(self.searchFilteredBy.lowercased())
                    }
                    
                    return isMatching
                })
                
                // Show button if has filters
                if !self.filters.isEmpty {
                    self.screen.showButton()
                }
                
                // Show exeption screen if filters results is empty
                if self.favorites.count == 0 {
//                    self.screen.presentEmptySearch(true, with: self.searchFilteredBy)
                } else {
                    self.screen.presentEmptySearch(false)
                }
            }
            
            if self.collectionState != .loading {
                DispatchQueue.main.async {
                    self.screen.favoritesTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        self.title = "Favorites"
        self.view = self.screen
        self.navigationItem.rightBarButtonItem = self.filterButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionState = .loading
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Table view reloading from refresh controll
    @objc func reloadTableView(_ sender: UIRefreshControl) {
        self.collectionState = .loading
        sender.endRefreshing()
    }
    
    // MARK: - Filter actions
    @objc func goToFilters() {
        let controller = FiltersController(filters: self.filters)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func removeFilters() {
        self.filters = [:]
        self.searchFilteredBy = ""
        self.collectionState = .loading
    }
}

// MARK: - Table view data source
extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.collectionState {
        case .loading:
            return 1
        case .loadError:
            return 0
        case .loadSuccess, .normal, .filtered:
            return self.favorites.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.collectionState == .loading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell",
                                                 for: indexPath) as? FavoriteMovieCell
        let movie = self.favorites[indexPath.row]
        cell?.setup(with: movie)
        return cell!
    }
}

// MARK: - Table view delegate
extension FavoritesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let movie = self.favorites.remove(at: indexPath.row)
            movie.isFavorite = false
            self.dataService.removeFromFavorites(movie.id)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.favorites[indexPath.row]
        let movieDetailControler = MovieDetailController(movie: movie)
        self.navigationController?.pushViewController(movieDetailControler,
                                                      animated: true)
    }
}

// MARK: - Search results updating
extension FavoritesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchFilteredBy = searchController.searchBar.text ?? ""
        // Set state according to filter existence
        if self.searchFilteredBy.isEmpty && self.filters.isEmpty {
            self.collectionState = .normal
        } else {
            self.collectionState = .filtered
        }
    }
}
