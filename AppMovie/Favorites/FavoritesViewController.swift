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
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = dataSource
        dataSource.datas = favorites
    }
}
extension FavoritesViewController: SendFavoritesFilmesDelegate {
    func send(favorites: [Movie]) {
        self.favorites = favorites
    }
}
