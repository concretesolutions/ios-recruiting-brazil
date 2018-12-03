//
//  FavoritesViewController.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import Nuke

class FavoritesViewController: UIViewController {
    
    var favMovies = [Detail]() {
        didSet {
            // Reload only when all favorite movies where fetched.
            if favMovies.count == favMoviesIds.count {
                favoritesTableView.reloadData()
            }
        }
    }
    var favMoviesIds = [Int]()
    
    let client = MovieAPIClient()
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPreviouslyFavoritedMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
    }
    
    private func loadPreviouslyFavoritedMovies() {
        if let array = UserDefaults.standard.array(forKey: "favMovies") as? [Int] {
            favMoviesIds = array
            loadFavoriteMovies()
        }
    }
    
    private func loadFavoriteMovies() {
        let activity = displayActivityIndicator(on: view)
        favMoviesIds.forEach { movieId in
            client.fetchMovie(with: movieId, completion: { (response) in
                self.removeActivityIndicator(activity)
                switch response {
                case .success(let detail):
                    if !self.favMovies.contains(detail) {
                        self.favMovies.append(detail)
                    }
                case .failure( _):
                    print("error fetching movie")
                }
            })
        }
    }
    
}

// MARK: UITableView Delegate and DataSource Methods

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoriteCell
        
        cell.movie = favMovies[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavoriteAction = unfavoriteMovie(at: indexPath)
        return UISwipeActionsConfiguration(actions: [unfavoriteAction])
    }
    
    func unfavoriteMovie(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, completion) in
            self.unfavorite(indexPath)
            self.favoritesTableView.deleteRows(at: [indexPath], with: .right)
            completion(true)
            
        }
        action.image = UIImage(imageLiteralResourceName: "unfavorite_icon")
        action.backgroundColor = .red
        return action
    }
    
    func unfavorite(_ index: IndexPath) {
        favMovies.remove(at: index.row)
        favMoviesIds.remove(at: index.row)
        UserDefaults.standard.set(favMoviesIds, forKey: "favMovies")
    }
    
    
}
