//
//  ListMoviesViewMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 03/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

@testable import Movs

class ListMoviesViewMock: ListMoviesView {
    var presenter: ListMoviesPresentation!
    
    var hasCalledShowNoContentScreen: Bool = false
    var hasCalledShowMoviesList: Bool = false
    var hasCalledUpdatePosters: Bool = false
    var hasCalledAdjustContraints: Bool = false
    
    
    func showNoContentScreen(image: UIImage?, message: String) {
        hasCalledShowNoContentScreen = true
    }
    
    func showMoviesList(_ movies: [MovieEntity]) {
        hasCalledShowMoviesList = true
    }
    
    func updatePosters(_ posters: [PosterEntity]) {
        hasCalledUpdatePosters = true
    }
    
    func adjustConstraints() {
        hasCalledAdjustContraints = true
    }
    
    
}
