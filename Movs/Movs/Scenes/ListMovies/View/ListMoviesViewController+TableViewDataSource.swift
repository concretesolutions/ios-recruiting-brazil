//
//  ListMoviesViewController+TableViewDataSource.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

// MARK: - Data Source
extension ListMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBarActive {
            return moviesFiltered.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellReuseIdentifier) as! PopularMovieTableViewCell
       
        if isSearchBarActive {
            cell.configureCellWith(data: moviesFiltered[indexPath.row], position: indexPath.row + 1)
        } else {
            if !movies.isEmpty {
                cell.configureCellWith(data: movies[indexPath.row], position: indexPath.row + 1)
            } else { cell.loadingCell() }
        }
        return cell
    }
    
}
