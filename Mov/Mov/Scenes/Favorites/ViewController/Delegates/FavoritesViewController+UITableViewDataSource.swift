//
//  FavoritesViewController+UITableViewDataSource.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let favoritesCell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableView.cellReuseIdentifier) as? FavoritesTableViewCell {
            if let viewModel = self.viewModels[safe: indexPath.row] {
                favoritesCell.favoritesUnit.viewModel = viewModel
            } else {/*do nothing*/}
            
            return favoritesCell
        }
        return FavoritesTableViewCell(frame: .zero)
    }
    
    
}
