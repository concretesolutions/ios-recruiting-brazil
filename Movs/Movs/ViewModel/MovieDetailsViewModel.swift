//
//  MovieDetailsViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine
import UIKit

class MovieDetailsViewModel {
    
    private var movie: Movie

    var title: String {
        return self.movie.title
    }
    var overview: String {
        if self.movie.overview.isEmpty {
            return "Without overview"
        }
        return self.movie.overview
    }
    var releaseYear: String {
        if self.movie.releaseDate.isEmpty {
            return "Without release year"
        }
        return String(self.movie.releaseDate.split(separator: "-")[0])
    }
    var posterImage: Published<UIImage>.Publisher {
        return self.movie.$posterImage
    }
    
    @Published var isLiked: Bool
    
    var genres: String {
        let genreNames = self.getGenresNames()
        if genreNames.isEmpty {
            return "Without genres"
        }
        return genreNames.joined(separator: ", ")
    }

    private(set) var posterImageCancellable: AnyCancellable?
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
    
    func toggleFavorite() {
        self.movie.toggleFavorite()
    }
    
    private func getYear(fromReleaseDate releaseDate: String) -> String {
        guard let releaseYear = releaseDate.components(separatedBy: "-").first else { return releaseDate }
        return releaseYear
    }
    
    private func getGenresNames() -> [String] {
        let genres = MovsService.shared.genres.filter { self.movie.genreIds.contains($0.id) }
        return genres.compactMap { $0.name }
    }

}
