//
//  FavoriteMoviesDataSource.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 06/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class FavoritesTableViewDataSource: NSObject {
    
    weak var tableView: UITableView?
    weak var delegate: UITableViewDelegate?
    var items: [Movie] = []
    
    required init(using item: [Movie], with tableView: UITableView, delegate: UITableViewDelegate) {
        super.init()
        self.items = item
        self.tableView = tableView
        self.delegate = delegate
        tableView.register(FavoriteMovieTableViewCell.nib(), forCellReuseIdentifier: FavoriteMovieTableViewCell.identifier())
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.delegate = self.delegate
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
    }
    
    func reloadData() {
        self.tableView?.reloadData()
    }
}

extension FavoritesTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.identifier(), for: indexPath) as? FavoriteMovieTableViewCell
            else { return UITableViewCell() }
        cell.setup(with: items[indexPath.row])
        return cell
    }
    
}
