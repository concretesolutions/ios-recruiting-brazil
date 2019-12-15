//
//  MovieDetailDataSource.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        if indexPath.row == 0 {
            cell.textLabel?.text = movie.title
        }
        if indexPath.row == 1 {
            cell.textLabel?.text = String(movie.releaseDate.prefix(4))
        }
        if indexPath.row == 2 {
            if genresString.isEmpty {
                movie.genreIDs.forEach({genreID in
                    genres.forEach({ genre in
                        if genreID == genre.genreID {
                            if !genresString.isEmpty {
                                genresString += ", "
                            }
                            genresString += genre.name
                        }
                    })
                })
            }
            cell.textLabel?.text = genresString
        }
        if indexPath.row == 3 {
            cell.textLabel?.text = movie.overview
        }
        return cell
    }

}
