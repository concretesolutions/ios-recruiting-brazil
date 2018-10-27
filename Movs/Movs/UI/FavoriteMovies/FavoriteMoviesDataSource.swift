//
//  FavoriteMoviesDataSource.swift
//  Movs
//
//  Created by Gabriel Reynoso on 26/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FavoriteMoviesDataSource: NSObject, UITableViewDataSource {
    
    var items: [FavoriteMoviesCell.Data]
    
    init(items: [FavoriteMoviesCell.Data] = []) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMoviesCell.identifier, for: indexPath) as? FavoriteMoviesCell else {
            return UITableViewCell()
        }
        cell.setupView()
        let data = self.items[indexPath.row]
        cell.configure(with: data)
        return cell
    }
}
