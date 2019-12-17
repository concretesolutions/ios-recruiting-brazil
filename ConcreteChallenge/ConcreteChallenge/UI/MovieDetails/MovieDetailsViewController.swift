//
//  MovieDetailsViewController.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 16/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailsViewController: UIViewController {

    private let movieDetailsView = MovieDetailsView()
    private let movie: Movie
    private var movieGenres: [Genre] = []

    weak var coordinator: Coordinator?

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = movieDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        movieDetailsView.setup(movie: movie) {
            self.saveFavorite(movie: self.movie)
        }
        fetchGenres()
        checkFavorited()
    }

    private func fetchGenres() {
        let provider = URLSessionProvider()
        provider.request(type: GenreListRoot.self, service: MovieDBService.movieGenres) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.handleFetched(data.genres)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func handleFetched(_ genres: [Genre]) {
        movieGenres.append(contentsOf: genres.filter({ movie.genreIDs.contains($0.id) }))
        movieDetailsView.updateGenres(with: movieGenres)
    }

    private func checkFavorited() {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", movie.id)
        if CoreDataStore.findFirst(fetchRequest) != nil {
            movieDetailsView.isFavorited = true
        }
    }

    private func removeFavorite(movie: Movie) {
        
    }

    private func saveFavorite(movie: Movie) {
        let newFavorite = FavoriteMovie(context: CoreDataStore.context)
        newFavorite.title = movie.title
        newFavorite.id = Int64(movie.id)
        newFavorite.overview = movie.overview
        newFavorite.posterImage = movie.posterImage?.jpegData(compressionQuality: 1.0)

        CoreDataStore.saveContext()
        movieDetailsView.isFavorited = true
    }
}
