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
    }
    
    private func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        dataSource.identifierCell = "favoriteMoveCell"
        dataSource.datas = ManagerMovies.shared.moviesFavorites
    }
}

//MARK: - Delegates
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
        action.backgroundColor = .red
        return action
    }
    
}
