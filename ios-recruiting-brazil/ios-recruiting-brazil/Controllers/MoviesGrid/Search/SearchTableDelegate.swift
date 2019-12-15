//
//  SearchTableDelegate.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension MoviesGridController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = searchedMovies[indexPath.row]
        let detailsController = MovieDetailViewController(withMovie: movie)
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
