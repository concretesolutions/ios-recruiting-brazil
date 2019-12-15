//
//  MoviesDataSource.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension MoviesGridController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MoviesCollectionViewCell.self)
        let movie = movies[indexPath.row]
        cell.movieName.text = movie.title
        cell.movieImage.image = nil

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

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 5 {
            pagesRequested += 1
            requestMovies(page: pagesRequested)
        }
    }

}
