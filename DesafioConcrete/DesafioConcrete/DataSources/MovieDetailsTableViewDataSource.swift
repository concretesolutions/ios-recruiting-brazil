//
//  MovieDetailTableViewDataSource.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailsTableViewDataSource: NSObject {
    
    weak var tableView: UITableView?
    var item: Movie?
    var genres: [Genre]?
    
    required init(using item: Movie, with tableView: UITableView, checking genres: [Genre]) {
        super.init()
        self.item = item
        self.genres = genres
        self.tableView = tableView
        tableView.register(MovieDetailsTitleTableViewCell.nib(), forCellReuseIdentifier: MovieDetailsTitleTableViewCell.identifier())
        tableView.register(MovieDetailsReleaseDateTableViewCell.nib(), forCellReuseIdentifier: MovieDetailsReleaseDateTableViewCell.identifier())
        tableView.register(MovieDetailsGenreTableViewCell.nib(), forCellReuseIdentifier: MovieDetailsGenreTableViewCell.identifier())
        tableView.register(MovieDetailsOverviewTableViewCell.nib(), forCellReuseIdentifier: MovieDetailsOverviewTableViewCell.identifier())
        self.tableView?.estimatedRowHeight = 120
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
    }
}

extension MovieDetailsTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        var cell = UITableViewCell()
        guard let movie = item else { return cell }
        if index == 0 {
            guard let cellTitle = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTitleTableViewCell.identifier(), for: indexPath) as? MovieDetailsTitleTableViewCell
                else { return cell }
            cellTitle.setup(with: movie)
            cellTitle.delegate = self
            cell = cellTitle
        } else if index == 1 {
            guard let cellReleaseDate = tableView.dequeueReusableCell(withIdentifier: MovieDetailsReleaseDateTableViewCell.identifier(), for: indexPath) as? MovieDetailsReleaseDateTableViewCell else { return cell }
            cellReleaseDate.setup(with: movie)
            cell = cellReleaseDate
        } else if index == 2 {
            guard let cellGenre = tableView.dequeueReusableCell(withIdentifier: MovieDetailsGenreTableViewCell.identifier(), for: indexPath) as? MovieDetailsGenreTableViewCell, let genres = genres else { return cell }
            cellGenre.setup(with: movie, checking: genres)
            cell = cellGenre
        } else {
            guard let cellOverview = tableView.dequeueReusableCell(withIdentifier: MovieDetailsOverviewTableViewCell.identifier(), for: indexPath) as? MovieDetailsOverviewTableViewCell
                else { return cell }
            cellOverview.setup(with: movie)
            cell = cellOverview
        }
        return cell
    }
}

extension MovieDetailsTableViewDataSource: FavoriteMovieDelegate {
    func favoriteMovie(movie: Movie) {
        guard let movie = item else { return }
        if DataManager.shared.checkData(movieId: movie.id) {
            DataManager.shared.deleteData(movieId: movie.id)
        } else {
            DataManager.shared.createData(movie: movie)
        }
        tableView?.reloadData()
    }
    
    func favoriteMovie() {
    }
}
