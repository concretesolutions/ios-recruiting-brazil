//
//  ListMoviesWireframeMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 05/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

@testable import Movs

class ListMoviesWireframeMock: ListMoviesWireframe {
    var viewController: UIViewController?
    
    var hasCalledPresentMovieDescription: Bool = false
    static var hasCalledAssembleModule: Bool = false
    
    func presentMovieDescription(movie: MovieEntity, genres: [GenreEntity], poster: PosterEntity?) {
        hasCalledPresentMovieDescription = true
    }
    
    static func assembleModule() -> UIViewController {
        hasCalledAssembleModule = true
        return UIViewController()
    }
    
}
