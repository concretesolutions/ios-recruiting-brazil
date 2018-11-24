//
//  FavoritesTableView.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 23/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class FavoritesTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var favoritedMovies: [Movie] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! FavoritesTableViewCell
        
        let movie = self.favoritedMovies[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let favoriteMovieToDelete = self.favoritedMovies[indexPath.row]
            CoreDataManager.deleteFavoriteMovie(title: favoriteMovieToDelete.title)
            
            self.favoritedMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath] , with: .automatic)
            
            
        }
        
    }
    

  

}
