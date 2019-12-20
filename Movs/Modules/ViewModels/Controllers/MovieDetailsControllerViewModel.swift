//
//  MovieDetailsControllerViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 16/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class MovieDetailsControllerViewModel {
    
    // MARK: - Properties
    
    internal var movieViewModel: MovieViewModel
    internal var genresNames: [String]
    internal var detailsContent: [(String, String?)]
    weak var coordinatorDelegate: MovieDetailsCoordinator?
    
    // MARK: - Initializers and Deinitializers
    
    init(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
        self.genresNames = Array(movieViewModel.genresNames)
        self.detailsContent = [
            ("Genres", nil),
            ("Summary", movieViewModel.summary),
            ("Release Year", movieViewModel.releaseYear)
        ]
    }
}

// MARK: - UITableView

extension MovieDetailsControllerViewModel {
    func detailForCellAt(indexPath: IndexPath) -> (String, String?) {
        return self.detailsContent[indexPath.row]
    }
}
