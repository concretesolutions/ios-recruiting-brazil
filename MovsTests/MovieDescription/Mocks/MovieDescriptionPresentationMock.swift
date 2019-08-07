//
//  MovieDescriptionPresentationMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 07/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class MovieDescriptionPresentationMock: MovieDescriptionPresentation {
    var hasCalledViewDidLoad: Bool = false
    var hasCalledDidFavoriteMovie: Bool = false
    
    var view: MovieDescriptionView?
    var router: MovieDescriptionWireframe!
    
    func viewDidLoad() {
        hasCalledViewDidLoad = true
    }
    
    func didFavoriteMovie() {
        hasCalledDidFavoriteMovie = true
    }

}
