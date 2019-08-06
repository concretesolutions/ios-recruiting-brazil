//
//  FavoriteMoviesViewMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 05/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

@testable import Movs

class FavoriteMoviesViewMock: FavoriteMoviesView {
    
    var hasCalledShowNoContentScreen: Bool = false
    var hasCalledShowFavoriteMoviesList: Bool = false
    var hasCalledAdjustContraints: Bool = false

    var presenter: FavoriteMoviesPresentation!
    var isFilterActive: Bool!
    
    func showNoContentScreen(image: UIImage?, message: String) {
        hasCalledShowNoContentScreen = true
    }
    
    func showFavoriteMoviesList(_ movies: [MovieEntity], posters: [PosterEntity], isFilterActive: Bool) {
        hasCalledShowFavoriteMoviesList = true
    }
    
    func adjustConstraints() {
        hasCalledAdjustContraints = true
    }

}
