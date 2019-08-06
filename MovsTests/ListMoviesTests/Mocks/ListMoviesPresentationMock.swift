//
//  ListMoviesPresentationMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 31/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class ListMoviesPresentationMock: ListMoviesPresentation {
    
    var hasCalledViewDidLoad: Bool = false
    var hasCalledDidEnterSearch: Bool = false
    var hasCalledDidSelectMovie: Bool = false
    
    var view: ListMoviesView?
    var interactor: ListMoviesUseCase!
    var router: ListMoviesWireframe!
    
    func viewDidLoad() {
        hasCalledViewDidLoad = true
    }
    
    func didEnterSearch(_ search: String) {
        hasCalledDidEnterSearch = true
    }
    
    func didSelectMovie(_ movie: MovieEntity) {
        hasCalledDidSelectMovie = true
    }
    
    
}
