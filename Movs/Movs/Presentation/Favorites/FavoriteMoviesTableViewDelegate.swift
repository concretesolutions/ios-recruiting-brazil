//
//  FavoriteMoviesTableViewDelegate.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import Reusable
import UIKit

final class FavoriteMoviesTableViewDelegate: NSObject, UITableViewDelegate {

    var favoritedMovies: [Movie] = []
    //swiftlint:disable weak_delegate
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

        let unfavoriteAction = UITableViewRowAction(style: .destructive, title: "common.unfavorite".localized) { _, indexPath in
            self.delegate?.deleteRowAt(indexPath: indexPath)
        }
        return[unfavoriteAction]
    }

}
