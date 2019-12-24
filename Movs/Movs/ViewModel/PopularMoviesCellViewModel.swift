//
//  PopularMoviesCellViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import UIKit
import Combine

class PopularMoviesCellViewModel {

    private var movie: Movie

    var title: String {
        return self.movie.title
    }
    var posterImage: Published<UIImage>.Publisher {
        return self.movie.$posterImage
    }
    @Published var isLiked: Bool
    
    private(set) var favoriteIdsSubscriber: AnyCancellable?

    init(withMovie movie: Movie) {
        self.movie = movie
        self.isLiked = PersistenceService.favoriteMovies.contains(self.movie.id)
        self.setCombine()
    }
    
    private func setCombine() {
        self.favoriteIdsSubscriber = PersistenceService.publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.isLiked = PersistenceService.favoriteMovies.contains(self.movie.id)
            })
    }

    public func toggleFavorite() {
        self.movie.toggleFavorite()
    }

}
