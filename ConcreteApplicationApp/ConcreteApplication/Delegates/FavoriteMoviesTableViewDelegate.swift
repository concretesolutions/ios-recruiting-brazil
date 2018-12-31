//
//  FavoriteMoviesTableViewDelegate.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class FavoriteMoviesTableViewDelegate: NSObject, UITableViewDelegate {
    
    var favoritedMovies:[Movie] = []
    var delegate: UnfavoriteMovieDelegate?
    
    init(favoritedMovies: [Movie], delegate: UnfavoriteMovieDelegate) {
        self.favoritedMovies = favoritedMovies
        self.delegate = delegate
        super.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.18
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let unfavoriteAction = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            self.delegate?.deleteRowAt(indexPath: indexPath)
        }
        return[unfavoriteAction]
    }
    
}
