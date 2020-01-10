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
        case loading, show
    }

    var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                self.setLoadingLayout?()
            case .show:
                self.setShowLayout?()
            }
        }
    }

    var model: Movie

    var isFavorited = false

    var networkManager: AnyNetworkManager!

    init(movie: Movie, networkManager: AnyNetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        self.model = movie
        do {
            self.isFavorited = try movie.isSaved()
        } catch {
            // TODO: send error to view
            debugPrint(error)
        }
    }

    // MARK: View content

    var title: String {
        model.title
    }
    var overview: String {
        model.overview
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

    var updateImage: VoidClosure?

    // MARK: User actions

    func favorite() {
        // TODO: Favorite on movie detail
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
                // TODO: send error to view
                debugPrint(error)
            }
        }
    }
}
