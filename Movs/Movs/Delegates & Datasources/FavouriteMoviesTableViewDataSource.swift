//
//  FavouriteMoviesTableViewDataSource.swift
//  Movs
//
//  Created by Erick Lozano Borges on 20/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

class FavouriteMoviesTableViewDataSource: NSObject, UITableViewDataSource {
    
    public var movies:[Movie]
    
    init(movies: [Movie], tableView: UITableView) {
        self.movies = movies
        super.init()
        registerCells(in: tableView)
    }
    
    private func registerCells(in tableView: UITableView) {
        tableView.register(cellType: FavouriteMoviesTableViewCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FavouriteMoviesTableViewCell.self)
        cell.setup(movies[indexPath.row])
        return cell
    }
    
}

