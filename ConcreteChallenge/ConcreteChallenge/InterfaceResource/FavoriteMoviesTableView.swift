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
    
    var isRemoveButtonEnabled = false
    
    var favoriteMovieRemoved: FavoriteMovieRemoved!
    
    // MARK: - UITableViewDelegate and UITableViewDataSource Functions
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.isRemoveButtonEnabled {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            view.backgroundColor = .white
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            button.setTitle("Remove Filter", for: .normal)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            
            view.addSubview(button)
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.isRemoveButtonEnabled {
            return 50
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovieCell", for: indexPath) as! FavoriteMovieTableViewCell
        
        cell.setupCell(movie: self.favoriteMovies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.favoriteMovieRemoved.didRemoveFavoriteMovie(at: indexPath)
            self.favoriteMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
}
