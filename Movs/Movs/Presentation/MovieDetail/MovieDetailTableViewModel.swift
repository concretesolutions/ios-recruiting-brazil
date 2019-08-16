//
//  MovieDetailTableViewModel.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import os

public protocol MovieDetailTableViewModelable: Registrable, FavoriteMovieDelegate {
    var movie: Movie { get }
    init(movie: Movie)
}

public class MovieDetailTableViewModel: MovieDetailTableViewModelable {

    public var movie: Movie

    required public init(movie: Movie) {
        self.movie = movie
    }
}

extension MovieDetailTableViewModel: FavoriteMovieDelegate {

    public func changeFavorite(to status: Bool) {
        if status == true {
            RealmManager.shared.save(object: self.movie.realm())
        } else {
            if let movieToDelete = RealmManager.shared.get(objectOf: MovieRealm.self, with: self.movie.id) {
                RealmManager.shared.delete(object: movieToDelete)
            }
        }
    }
}
