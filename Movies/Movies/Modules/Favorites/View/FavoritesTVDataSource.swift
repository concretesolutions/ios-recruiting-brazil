//
//  FavoritesTVDataSource.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Favorite"

class FavoritesTVDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    private var movies: [Movie] = []
    private weak var tableView: FavoritesTableView?
    private var presenter: FavoritesPresentation
    
    // MARK: - Initializers
    
    init(tableView: FavoritesTableView, presenter: FavoritesPresentation) {
        self.tableView = tableView
        self.presenter = presenter
    }
    
    // MARK: - UITableViewDataSource protocol functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let favoriteCell = reusableCell as? FavoriteTableViewCell {
            favoriteCell.set(movie: self.movies[indexPath.row])
        }
        
        return reusableCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.presenter.didUnfavorite(movie: self.movies[indexPath.row])
            self.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Util functions
    
    func update(movies: [Movie]) {
        self.movies = movies
        self.tableView?.reloadData()
    }
    
    func delete(movieAt index: Int) {
        self.movies.remove(at: index)
    }
    
}
