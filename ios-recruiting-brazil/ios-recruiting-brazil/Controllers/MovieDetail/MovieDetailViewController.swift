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
    let coreDataManager = CoreDataManager()
    var fetchedMovies = [Movie]()
    var genresString = ""
    var genres = [GenreDTO]() {
        didSet {
            DispatchQueue.main.async {
                self.customView.detailsTable.reloadData()
            }
        }
    }

    convenience init(withMovie movie: Movie) {
        let movieDTO = MovieDTO(title: movie.name ?? "",
                                overview: movie.overview ?? "", poster: "",
                                releaseDate: movie.date ?? "", genreIDs: [0])
        self.init(withMovie: movieDTO)
        if let imageData = movie.image, let genres = movie.genres {
            customView.movieImage.image = UIImage(data: imageData)
            genresString = genres
        }

    }
    init(withMovie movie: MovieDTO) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        requestGenres()
        requestImage()
        if let movies = coreDataManager.fetchMovies() {
            self.fetchedMovies = movies
        }
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
    func checkMovieFavorite() -> Bool {
        var isFavorite = false
        fetchedMovies.forEach({
            if $0.name == movie.title {
            isFavorite = true
            }
        })
        return isFavorite
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

    @objc func favoriteButtonClicked(sender: Any) {
        guard let button = sender as? UIButton else {return}
        if checkMovieFavorite() {
            button.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
            coreDataManager.deleteMovie(withName: movie.title)
        } else {
            button.setImage(UIImage(named: "favorite_full_icon"),
            for: .normal)
            coreDataManager.saveMovie(name: movie.title, genres: "",
                                      overview: movie.overview, date: movie.releaseDate,
                                      image: customView.movieImage.image)
        }

        if let movies = coreDataManager.fetchMovies() {
            self.fetchedMovies = movies
        }
    }
}
