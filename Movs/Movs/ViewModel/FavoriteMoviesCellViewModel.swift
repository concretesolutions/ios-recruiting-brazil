//
//  FavoriteMoviesCellViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine
import UIKit

class FavoriteMoviesCellViewModel {

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
            return "...."
        }
        return String(self.movie.releaseDate.split(separator: "-")[0])
    }
    var posterImage: Published<UIImage>.Publisher {
        return self.movie.$posterImage
    }

    private var posterImageCancellable: AnyCancellable?

    init(withMovie movie: Movie) {
        self.movie = movie
    }
    
    func toggleFavorite() {
        self.movie.toggleFavorite()
    }
    
    private func getYear(fromReleaseDate releaseDate: String) -> String {
        guard let releaseYear = releaseDate.components(separatedBy: "-").first else { return releaseDate }
        return releaseYear
    }

}
