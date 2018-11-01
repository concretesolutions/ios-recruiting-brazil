//
//  FavoritesTableViewDataSource.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 31/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId) as? FavoritesCustomCell else {
            return FavoritesCustomCell(style: .default, reuseIdentifier: self.cellId)
        }
        cell.setData(data: displayedMovies[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
