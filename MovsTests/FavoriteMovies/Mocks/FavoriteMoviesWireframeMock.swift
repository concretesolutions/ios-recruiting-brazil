//
//  FavoriteMoviesWireframeMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 05/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

@testable import Movs

class FavoriteMoviesWireframeMock: FavoriteMoviesWireframe {
    
    var hasCalledPresentFavoriteMovieDescription: Bool = false
    var hasCalledPresentFilterSelection: Bool = false
    static var hasCalledAssembleModule: Bool = false
    
    var viewController: UIViewController?
    
    func presentFavoriteMovieDescription(movie: MovieEntity, genres: [GenreEntity], poster: PosterEntity?) {
        hasCalledPresentFavoriteMovieDescription = true
    }
    
    func presentFilterSelection(movies: [MovieEntity]) {
        hasCalledPresentFilterSelection = true
    }
    
    static func assembleModule() -> UIViewController {
        hasCalledAssembleModule = true
        return UIViewController()
    }

}
