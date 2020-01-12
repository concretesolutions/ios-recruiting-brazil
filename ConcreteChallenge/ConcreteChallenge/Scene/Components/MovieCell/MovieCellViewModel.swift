//
//  MovieCellViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class MovieCellViewModel: ViewModel {
    enum State { case show }
    var state: State = .show

    var model: Movie

    var isFavorited = false {
        didSet {
            updateFavoriteState?()
        }
    }

    init(movie: Movie) {
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
            // TODO: send error to view
            debugPrint(error)
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
}
