//
//  FavoriteMoviesUITableView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 16/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class GenreFilterTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var genres: [Genre] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    var tableViewActions: GenreFilterTableViewActions!
    
    // MARK: - UITableViewDelegate and UITableViewDataSource Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreFilterCell", for: indexPath) as! GenreFilterTableViewCell
        
        cell.setupCell(genre: self.genres[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.tableViewActions.didSelectGenre(genre: genres[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.cellForRow(at: indexPath)?.accessoryType = .none
        self.tableViewActions.didDeselectGenre(genre: genres[indexPath.row])
    }
}
