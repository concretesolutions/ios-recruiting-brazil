//
//  Protocols.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 15/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation

protocol MovieCellSelected: class {
    func didTap(at movieCell: MoviesCollectionViewCell)
}

protocol MoviesDataFetchCompleted: class {
    func fetchComplete(for movies: [Movie])
}

protocol GenresDataFetchCompleted: class {
    func fetchComplete(for genres: [Genre])
}

protocol PresentMessageForException: class {
    func presentEmptySearchMessage(with searchText: String)
    func presentGenericErrorMessage()
}

protocol LoadMoreContentAfterPagination: class {
    func loadMoreMovies()
}
