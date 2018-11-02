//
//  FavoritesViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 24/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    var dataSource = FavoriteTableViewDataSource()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.dataSource.datas = ManagerMovies.shared.moviesFavorites
        self.tableView.reloadData()
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.barTintColor = Colors.navigationController.value
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = dataSource
        tableView.delegate = self
        dataSource.identifierCell = "favoriteMoveCell"
        dataSource.datas = ManagerMovies.shared.moviesFavorites
    }
}

//MARK: - Delegates
extension FavoritesViewController: FavoriteMovieDelegate {
    func setFavorite(movie: MovieNowPlaying) {
        ManagerMovies.shared.moviesFavorites.append(movie)
        
        let index = Index.getIndexInArray(movie: movie, at: ManagerMovies.shared.movies)
        ManagerMovies.shared.movies[index].updateFavorite()
        self.dataSource.datas = ManagerMovies.shared.movies
        self.tableView.reloadData()
    }
    
    func removeFavorite(movie: MovieNowPlaying) {
        let index = Index.getIndexInArray(movie: movie, at: ManagerMovies.shared.moviesFavorites)
        if  index != -1 {
            ManagerMovies.shared.moviesFavorites.remove(at: index)
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, completion) in
            let index = Index.getIndexInArray(movie: ManagerMovies.shared.moviesFavorites[indexPath.row], at: ManagerMovies.shared.movies)
            ManagerMovies.shared.moviesFavorites.remove(at: indexPath.row)
            self.dataSource.datas = ManagerMovies.shared.moviesFavorites
            ManagerMovies.shared.movies[index].updateFavorite()
            self.tableView.reloadData()
        }
        return action
    }
    
}
