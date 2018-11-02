//
//  FavoritesWorker.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

protocol FavoritesWorkingLogic {
    func fetchPoster(posterPath: String) -> UIImageView
}

class FavoritesWorker: FavoritesWorkingLogic {
    func fetchPoster(posterPath: String) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        let url = URL(string: MovieService.baseImageURL + posterPath)
        imageView.kf.setImage(with: url)
        return imageView
    }
}
