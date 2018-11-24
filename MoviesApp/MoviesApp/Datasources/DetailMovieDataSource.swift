//
//  DetailMovieDataSource.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 17/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

final class DetailMovieDataSource:NSObject{
    
    var movie:Movie
    var genres:[Genre]
    weak var tableView:UITableView?
    weak var delegate:UITableViewDelegate?
    
    required init(movie:Movie, genres:[Genre], tableView:UITableView, delegate:UITableViewDelegate){
        self.movie = movie
        self.genres = genres
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        
        tableView.register(cellType: MoviePosterTableViewCell.self)
        tableView.register(cellType: MovieTitleTableViewCell.self)
        tableView.register(cellType: MovieDescriptionTableViewCell.self)
        tableView.register(cellType: MovieInfoTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = delegate
    }
    
}

extension DetailMovieDataSource:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MoviePosterTableViewCell.self)
            cell.setup(with: movie)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieTitleTableViewCell.self)
            cell.genres = self.genres
            cell.setup(with: movie)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieInfoTableViewCell.self)
            cell.setup(with: movie, genres: genres)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDescriptionTableViewCell.self)
            cell.setup(with: movie)
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieInfoTableViewCell.self)
            cell.setup(with: movie, row: indexPath.row)
            return cell
        }
    }
    
}
