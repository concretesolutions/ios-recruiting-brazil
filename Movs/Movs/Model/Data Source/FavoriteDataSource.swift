//
//  FavoriteDataSource.swift
//  Movs
//
//  Created by Julio Brazil on 25/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FavoriteCell"

extension FavoritesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let amountOfMovies = self.isFiltering ? self.filteredFavorites.count : self.favorites.count
        return self.isFiltering ? amountOfMovies + 1 : amountOfMovies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var rowNumber = indexPath.row
        
        if self.isFiltering {
            rowNumber -= 1
        }
        
        if rowNumber == -1 {
            return {
                let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                cell.backgroundColor = .MovGray
                cell.textLabel?.text = "Remove Filter"
                cell.textLabel?.textColor = .red
                cell.textLabel?.textAlignment = .center
                return cell
            }()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FavoriteTableViewCell
        
        cell.movie = self.isFiltering ? self.filteredFavorites[rowNumber] : self.favorites[rowNumber]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var rowNumber = indexPath.row
        
        if self.isFiltering {
            rowNumber -= 1
        }
        
        if rowNumber == -1 {
            self.removeFilter()
            return
        }
        
        let detailView = MovieDetailsTableViewController(presenting: self.isFiltering ? self.filteredFavorites[rowNumber] : self.favorites[rowNumber])
        detailView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoriteManager.shared.unfavoriteMovie(withID: self.favorites[indexPath.row].id)
            self.favorites = FavoriteManager.shared.favorites
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
