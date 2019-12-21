//
//  MovieCellViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

class MovieCellViewModel: ObservableObject {
    private var movie: Movie
    
    var title: String {
        return self.movie.title
    }
    
    var posterURL: URL {
        return self.movie.posterURL
    }
    
    @Published var favorite: Bool
    
    var toggleFavorite: () -> Void // Toggle favorite handler
    
    // Cancellables
    private var favoriteIdsSubscriber: AnyCancellable?

    init(of movie: Movie, dataProvider: DataProvidable = DataProvider.shared) {
        self.movie = movie
        self.favorite = dataProvider.isFavorite(self.movie.id)
        self.toggleFavorite = {
            dataProvider.toggleFavorite(withId: movie.id)
        }
        
        favoriteIdsSubscriber = dataProvider.favoriteMoviesPublisher
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] _ in
                guard let id = self?.movie.id else { return }
                self?.favorite = dataProvider.isFavorite(id)
            })
    }
}

// MARK: - Favorite button delegate
extension MovieCellViewModel: FavoriteButtonDelegate {
    func click() {
        self.toggleFavorite()
    }
}
