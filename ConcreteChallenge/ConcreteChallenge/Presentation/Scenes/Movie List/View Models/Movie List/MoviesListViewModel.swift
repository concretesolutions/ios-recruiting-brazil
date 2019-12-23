//
//  MoviesListViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

/// a view model that provides data to lists of movies
protocol MoviesListViewModel: AnyObject {
    var numberOfMovies: Int { get }
    var currentPresentation: Int { get }
    var navigator: MoviesListViewModelNavigator? { get set }
    var emptyStateDescription: String { get }
        
    // bellow methods are for data biding with the view
    var needShowError: ((_ message: String) -> Void)? { get set }
    var needShowNewMovies: ((_ atRange: Range<Int>) -> Void)? { get set }
    var needReloadAllMovies: (() -> Void)? { get set }
    var needReloadMovieView: ((_ position: Int) -> Void)? { get set }
    var needDeleteMovieView: ((_ position: Int) -> Void)? { get set }
    var needInsertMovieView: ((_ position: Int) -> Void)? { get set }
    var needChangeEmptyStateVisibility: ((_ visible: Bool) -> Void)? { get set }
    var needChangeLoadingStateVisibility: ((_ visible: Bool) -> Void)? { get set }
    
    // methods bellow are called by the view to say changes to the view model
    func thePageReachedTheEnd()
    func viewModelFromMovie(atPosition position: Int) -> MovieViewModel
    func viewStateChanged(toState state: Int)
    func userSelectedMovie(atPosition position: Int)
    
    // the methods bellow are called by other classes, so the view model can perform necessary things.
    func reloadMovie(_ movie: Movie)
    func insertMovie(_ movie: Movie)
    func deleteMovie(_ movie: Movie)
    func deleteAllMovies()
}
