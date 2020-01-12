//
//  MovieDetailViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import NetworkLayer
import UIKit

class MovieDetailViewModel: ViewModel {
    enum State {
        case loading, show, error(Error)
    }

    var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                self.setLoadingLayout?()
            case .show:
                self.setShowLayout?()
            case .error(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.showError?(error)
                }
            }
        }
    }

    var model: Movie

    var isFavorited = false {
        didSet {
            updateFavoriteState?()
        }
    }

    var networkManager: AnyNetworkManager!

    init(movie: Movie, networkManager: AnyNetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        self.model = movie

        loadFavoriteState()
    }

    // MARK: View content

    var title: String {
        model.title
    }
    var overview: String {
        model.overview
    }
    var genres: String {
        guard let genres = model.genres?.allObjects as? [Genre] else {
            return "No genres"
        }
        return genres.map({ $0.name }).joined(separator: ", ")
    }
    var releaseYear: String {
        let formatter = DateFormatter()
            .set(\.dateFormat, to: "YYYY")
        return formatter.string(from: model.releaseDate)
    }
    var favoriteIcon: UIImage {
        isFavorited
            ? UIImage.Favorite.fullIcon
            : UIImage.Favorite.emptyIcon
    }
    var image: UIImage = UIImage.placeholder

    // MARK: View updates

    var setLoadingLayout: VoidClosure?
    var setShowLayout: VoidClosure?
    var showError: ErrorClosure?

    var updateFavoriteState: VoidClosure?
    var updateImage: VoidClosure?

    // MARK: User actions

    @objc
    func favorite() {
        isFavorited = !isFavorited

        do {
            if isFavorited {
                try model.deepCopy()
                try CoreDataManager.shared.saveContext()
            } else {
                if let movieSaved = try Movie.queryById(Int(model.id)) {
                    try CoreDataManager.getContext().delete(movieSaved)
                    try CoreDataManager.shared.saveContext()
                }
            }
        } catch {
            self.state = .error(error)
        }
    }

    func loadImage() {
        ImageLoader.loadImageUsingCache(from:
            URL(string: "https://image.tmdb.org/t/p/w500" + model.imagePath)
        ) { [weak self] image in
            self?.image = image
            DispatchQueue.main.async {
                self?.updateImage?()
            }
        }
    }

    func loadGenres() {
        state = .loading

        networkManager.request(MovieService.movie(id: Int(model.id))) { [weak self] (result: Result<Movie, Error>) in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async { [weak self] in
                    self?.model = movie
                    self?.state = .show
                }
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }

    func loadFavoriteState() {
        do {
            isFavorited = try model.isSaved()
        } catch {
            self.state = .error(error)
        }
    }
}
