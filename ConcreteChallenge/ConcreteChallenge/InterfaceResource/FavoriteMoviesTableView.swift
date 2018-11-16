//
//  FavoriteMoviesUITableView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 16/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class FavoriteMoviesTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var favoriteMovies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovieCell", for: indexPath) as! FavoriteMovieTableViewCell
        
        cell.setupCell(movie: self.favoriteMovies[indexPath.row])
        
        return cell
    }
}
