//
//  FavoritesTableDataSource.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MoviesTableViewCell.self)
        let movie = movies[indexPath.row]
        cell.movieName.text = movie.name
        cell.movieDescription.text = movie.overview
        if let date = movie.date {
            cell.date.text = String(date.prefix(4))
        }
        if let imageData = movie.image {
            cell.movieImage.image = UIImage(data: imageData)
        }
        return cell
    }

}
