//
//  FavoritesViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 24/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    var favorites = [Movie]()
    var dataSource = FavoriteTableViewDataSource()
    var dadController : InitialViewController?
    var delegateFavoriteDad: FavoriteMovieDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        delegateFavoriteDad = dadController
    }

    private func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        dataSource.datas = favorites
    }
}

//MARK: - Delegates
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.delegateFavoriteDad?.removeFavorite(movie: self.favorites[indexPath.row])
        }
        action.backgroundColor = .red
        return action
    }
    
}

extension FavoritesViewController: SendFavoritesFilmesDelegate {
    func send(favorites: [Movie]) {
        self.favorites = favorites
    }
}

extension FavoritesViewController: ReceiveFavoriteDelegate {
    func receive(favorites: [Movie]) {
        self.favorites = favorites
        self.tableView.reloadData()
    }
}

extension FavoritesViewController: SendDataDelegate {
    func send(data: Any) {
        if let _moviesFavorites = data as? [Movie] {
            self.favorites = _moviesFavorites
            self.dataSource.datas = _moviesFavorites
            self.dataSource.controller = self.dadController
            self.dataSource.identifierCell = "favoriteMoveCell"
            self.tableView.reloadData()
        }
    }
}
