//
//  FavoriteMoviesTableViewDataSource.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import Reusable
import UIKit

protocol UnfavoriteMovieDelegate: AnyObject {
    func deleteRowAt(indexPath: IndexPath)
}

final class FavoriteMoviesTableViewDataSource: NSObject, UITableViewDataSource {

    var favoritedMovies: [Movie] = []

    init(favoritedMovies: [Movie], tableView: UITableView) {
        self.favoritedMovies = favoritedMovies
        super.init()
        tableView.register(cellType: FavoriteMovieTableViewCell.self)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritedMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteMovieCell = tableView.dequeueReusableCell(for: indexPath, cellType: FavoriteMovieTableViewCell.self)
        favoriteMovieCell.setup(movie: favoritedMovies[indexPath.row])
        return favoriteMovieCell
    }
}
