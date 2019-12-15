//
//  MoviesDetailViewController.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class MovieDetailViewController: UIViewController {
    let customView = MovieDetailView()
    let movie: MovieDTO
    var genres = [GenreDTO]() {
        didSet {
            DispatchQueue.main.async {
                self.customView.detailsTable.reloadData()
            }
        }
    }
    init(withMovie movie: MovieDTO) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        requestGenres()
        requestImage()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customView.detailsTable.dataSource = self
    }

    private func requestImage() {
        let service = MovieService.getImage(movie.poster)
        let session = URLSessionProvider()
        session.request(type: Data.self, service: service) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.customView.movieImage.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func requestGenres() {
        let service = MovieService.getGenres
        let session = URLSessionProvider()
        session.request(type: GenresDTO.self, service: service) { (result) in
            switch result {
            case .success(let genres) :
                self.genres = genres.genres
            case .failure(let error):
                print(error)
            }
        }
    }
}
