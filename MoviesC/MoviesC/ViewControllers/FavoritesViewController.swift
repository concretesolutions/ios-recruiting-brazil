//
//  FavoritesViewController.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favMovies = [Movie]()
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
}

// MARK: UITableView Delegate and DataSource Methods

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoriteCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavoriteAction = unfavoriteMovie(at: indexPath)
        return UISwipeActionsConfiguration(actions: [unfavoriteAction])
    }
    
    func unfavoriteMovie(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, completion) in
            // TODO: remove movie from favMovies
            // remove movie from user defaults
            self.favoritesTableView.deleteRows(at: [indexPath], with: .right)
            completion(true)
        }
        action.image = UIImage(imageLiteralResourceName: "favorite_empty_icon")
        action.backgroundColor = .red
        return action
    }
    
    
}
