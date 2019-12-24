//
//  MovieDetailsControllerViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 16/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieDetailsControllerViewModel {
    
    // MARK: - Data Sources
    
    internal var movieViewModel: MovieViewModel
    private var genresNames: [String]
    private var detailsContent: [(String, String?)]

    // MARK: - Properties

    unowned var coordinator: MovieDetailsCoordinator!
    
    // MARK: - Outputs
    
    public var numberOfDetails: Int {
        return self.detailsContent.count
    }
    
    public var numberOfGenres: Int {
        return self.genresNames.count
    }
    
    // MARK: - Initializers and Deinitializers
    
    init(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
        self.genresNames = Array(movieViewModel.genresNames).sorted()
        self.detailsContent = [
            ("Genres", nil),
            ("Summary", movieViewModel.summary),
            ("Release Year", movieViewModel.releaseYear)
        ]
    }
}

// MARK: - UITableView

extension MovieDetailsControllerViewModel {
    func detailsForItemAt(indexPath: IndexPath) -> (String, String?) {
        return self.detailsContent[indexPath.row]
    }
}

// MARK: - UICollectionView

extension MovieDetailsControllerViewModel {
    func genreNameForItemAt(indexPath: IndexPath) -> String {
        return self.genresNames[indexPath.row]
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        return self.genresNames[indexPath.row].size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold)
        ])
    }
}
