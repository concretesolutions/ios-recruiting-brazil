//
//  FavoritesTableViewDelegate.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 06/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class FavoritesTableViewDelegate: NSObject {
    
    let delegate: FavoritesDelegate
    
    init(_ delegate: FavoritesDelegate) {
        self.delegate = delegate
    }
}

extension FavoritesTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavoriteAction = UIContextualAction(style: .destructive, title: "Unfavorite", handler: { _,_,_ in
            self.delegate.unfavoriteMovie(at: indexPath.row)
        })
        unfavoriteAction.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2394097075, alpha: 1)
        return UISwipeActionsConfiguration(actions: [unfavoriteAction])
    }
}
