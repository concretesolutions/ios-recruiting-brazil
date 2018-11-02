//
//  Favorites+DataSource+Delegate.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoritesTableViewCell
        
        cell.title.text = movies[indexPath.row].title
        cell.year.text = movies[indexPath.row].year
        cell.overview.text = movies[indexPath.row].overview
        cell.imageView?.image = movies[indexPath.row].imageView.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let unfavoriteAction = UITableViewRowAction(style: .destructive,
                                                    title: "Unfavorite") { (action, indexPath) in
            self.interactor.unfavoriteMovie(at: indexPath.row)
        }
        
        return [unfavoriteAction]
    }
}
