//
//  FavouriteMoviesViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

class FavouriteMoviesViewController: UIViewController {

    let db = RealmManager.shared
    let tableView = FavouriteMoviesTableView()
    var tableViewDelegate: FavouriteMoviesTableViewDelegate?
    var tableViewDataSource: FavouriteMoviesTableViewDataSource?
    let searchController = UISearchController(searchResultsController: nil)
    
    var favouriteMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getFavouriteMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavouriteMovies()
        setupSearchBar()
    }
    
    func setupTableView(with movies: [Movie]) {
        tableViewDataSource = FavouriteMoviesTableViewDataSource(movies: movies, tableView: tableView)
        tableView.dataSource = tableViewDataSource
        
        tableViewDelegate = FavouriteMoviesTableViewDelegate(movies: movies, delegate: self)
        tableView.delegate = tableViewDelegate
        
        tableView.reloadData()
    }
    
    func getFavouriteMovies() {
        favouriteMovies.removeAll()
        db.getAll(MovieRlm.self).forEach({ favouriteMovies.append(Movie($0)) })
        setupTableView(with: favouriteMovies)
    }
    
}

extension FavouriteMoviesViewController: MovieSelectionDelegate {
    func didSelect(movie: Movie) {
        let movieVC = MovieTableViewController(movie: movie)
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    func unfavouriteSelected(movie: Movie, indexPath: IndexPath) {
        if let deleteMovie = db.get(MovieRlm.self, withPrimaryKey: movie.id) {
            db.delete(deleteMovie)
            tableViewDataSource?.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print("Deleted from Realm")
        }
    }
}

extension FavouriteMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = Design.colors.white
        navigationController?.navigationBar.tintColor = Design.colors.dark
        navigationController?.navigationBar.barTintColor = Design.colors.mainYellow
    }
    
}

extension FavouriteMoviesViewController: UISearchBarDelegate {
    func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.searchController?.isActive = true
        definesPresentationContext = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBarIsEmpty() {
            setupTableView(with: favouriteMovies)
        } else {
            filterContentForSearchText(searchText)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBarIsEmpty() {
            setupTableView(with: favouriteMovies)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        setupTableView(with: favouriteMovies)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let filteredMovies = favouriteMovies.filter({$0.title.lowercased().contains(searchText.lowercased())})
        setupTableView(with: filteredMovies)
    }
    
}
