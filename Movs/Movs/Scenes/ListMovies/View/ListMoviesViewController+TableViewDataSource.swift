//
//  ListMoviesViewController+TableViewDataSource.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

extension ListMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellReuseIdentifier) as! PopularMovieTableViewCell
        if !movies.isEmpty {
            cell.configureCellWith(data: movies[indexPath.row])
        }
        return cell
    }
    
    
    
    
    
}
