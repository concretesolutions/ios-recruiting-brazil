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
    
    // Cancellables
    private var favoriteIdsSubscriber: AnyCancellable?

    init(of movie: Movie) {
        self.movie = movie
        self.favorite = UserDefaults.standard.isFavorite(self.movie.id)
        
        favoriteIdsSubscriber = UserDefaults.standard.publisher(for: \.favorites)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let id = self?.movie.id else { return }
                self?.favorite = UserDefaults.standard.isFavorite(id)
            })
    }
    
    public func toggleFavorite() {
        UserDefaults.standard.toggleFavorite(withId: self.movie.id)
    }
}

// MARK: - Favorite button delegate
extension MovieCellViewModel: FavoriteButtonDelegate {
    func click() {
        self.toggleFavorite()
    }
}
