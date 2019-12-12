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
        let item = UIBarButtonItem(barButtonSystemItem: .add,
                                   target: self,
                                   action: #selector(goToFilters))
        return item
    }()
    
    // MARK: - Attributes
    lazy var screen = FavoritesScreen(delegate: self)
    let dataService = DataService.shared
    var filteredBy = ""
    var favorites: [Movie] = []
    var collectionState: CollectionState = .loading {
        didSet {
            switch self.collectionState {
            case .loading:
                return
            case .loadSuccess:
                self.favorites = self.dataService.favorites
                DispatchQueue.main.async {
                    self.screen.favoritesTableView.reloadData()
                }
            case .loadError:
                self.screen.showErrorView()
                DispatchQueue.main.async {
                    self.screen.favoritesTableView.reloadData()
                }
            case .normal:
                self.screen.presentEmptySearch(false)
                self.favorites = self.dataService.favorites
                DispatchQueue.main.async {
                    self.screen.favoritesTableView.reloadData()
                }
            case .filtered:
                self.favorites = self.dataService.favorites.filter({ (movie) -> Bool in
                    return movie.title.lowercased().contains(self.filteredBy.lowercased())
                })
                
                if self.favorites.count == 0 {
                    self.screen.presentEmptySearch(true)
                } else {
                    self.screen.presentEmptySearch(false)
                }
                
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
        self.dataService.loadFavorites { (state) in
            self.collectionState = state
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.screen.favoritesTableView.reloadData()
    }
    
    // MARK: - Navigation controller action
    @objc func goToFilters() {
        let controller = FiltersController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

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
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell",
                                                     for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell",
                                                 for: indexPath) as? FavoriteMovieCell
        let movie = self.favorites[indexPath.row]
        cell?.setup(with: movie)
        return cell!
    }
}

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
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailControler = MovieDetailController(movie: self.favorites[indexPath.row])
            self.navigationController?.pushViewController(movieDetailControler,
                                                          animated: true)
    }
}

extension FavoritesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        self.filteredBy = text
        if text == "" {
            self.collectionState = .normal
        } else {
            self.collectionState = .filtered
        }
    }
}
