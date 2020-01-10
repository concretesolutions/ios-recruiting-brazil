//
//  MovieCellViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class MovieCellViewModel: ViewModel {
    enum State {
        case unfavorited, favorited
    }
    var state: State = .unfavorited

    var model: Movie

    init(model: Movie) {
        self.model = model
    }

    // MARK: View content

    var title: String {
        model.title
    }
    var favoriteIcon: UIImage {
        if state == .favorited {
            return UIImage.Favorite.fullIcon
        }
        return UIImage.Favorite.emptyIcon
    }
    var image: UIImage = UIImage.placeholder

    // MARK: View updates

    var updateImage: VoidClosure?

    // MARK: User actions

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
