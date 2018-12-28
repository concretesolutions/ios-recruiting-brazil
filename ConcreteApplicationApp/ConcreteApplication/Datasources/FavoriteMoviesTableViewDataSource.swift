//
//  FavoriteMoviesTableViewDataSource.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation
import UIKit
import Reusable

protocol UnfavoriteMovieDelegate {
    func deleteRowAt(indexPath: IndexPath)
}

final class FavoriteMoviesTableViewDataSource: NSObject, UITableViewDataSource {
    
    var favoritedMovies:[Movie] = []
    
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
