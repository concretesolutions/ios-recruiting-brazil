//
//  FavoriteMoviesTableViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 07/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import UIKit
import CoreData

class FavoriteMoviesTableViewController: UITableViewController {
    
    private var label = UILabel()
    private let cellIdentifier = "favoriteMovieCell"
    private var favoriteMoviesManager: FavoriteMoviesManagerProtocol = FavoriteMoviesManager()
    private var favoriteMovieData: [FavoriteMovieData] = []
    private let appearance = UINavigationBarAppearance()
    @IBOutlet weak var errorView: ErrorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        label.text = "Sem filmes cadastrados"
        label.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteMovies()
        tableView.reloadData()
    }
    
    private func setupUI() {
        setupNavigationBarAppearance(appearance: appearance)
        setupSearchController(delegate: self)
    }
    
    private func loadFavoriteMovies(filter: String = "") {
        
        if favoriteMoviesManager.fetch(filtering: filter)?.count == 0 && !filter.isEmpty {
            errorView.type = .notFound(searchText: filter)
            errorView.isHidden = false
        }
        if let favoriteMovies = favoriteMoviesManager.fetch(filtering: filter) {
            self.favoriteMovieData = favoriteMovies
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        tableView.backgroundView = favoriteMovieData.count == 0 ? label : nil
        return favoriteMovieData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteMovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.prepare(with: favoriteMovieData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let favoriteMovie = favoriteMovieData[indexPath.row]
            favoriteMoviesManager.delete(id: favoriteMovie.id)
            favoriteMovieData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FavoriteMoviesTableViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        errorView.isHidden = true
        loadFavoriteMovies()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        loadFavoriteMovies(filter: searchText)
        tableView.reloadData()
    }
}
