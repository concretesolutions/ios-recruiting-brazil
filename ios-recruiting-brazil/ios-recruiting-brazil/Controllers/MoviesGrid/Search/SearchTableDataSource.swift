//
//  SearchTableDataSource.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class SearchTableDataSource: NSObject, UITableViewDataSource {

    var searchedMovies = [MovieDTO]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MoviesTableViewCell.self)
        let movie = searchedMovies[indexPath.row]
        cell.movieName.text = movie.title
        cell.movieDescription.text = movie.overview
        cell.date.text = String(movie.releaseDate.prefix(4))
        cell.imageView?.image = nil

        let service = MovieService.getImage(movie.poster)
        let session = URLSessionProvider()
        session.request(type: Data.self, service: service) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.sync {
                    cell.movieImage.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}
