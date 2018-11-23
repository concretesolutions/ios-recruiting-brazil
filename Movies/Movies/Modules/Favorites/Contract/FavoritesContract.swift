//
//  FavoritesContract.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

protocol FavoritesView: class {
    
    var presenter: FavoritesPresentation! { get set }
    
    func present(movies: [Movie])
    func showRemoveFilterButton()
    func hideRemoveFilterButton()
    
}

protocol FavoritesPresentation {
    
    var view: FavoritesView? { get set }
    var router: FavoritesWireframe! { get set }
    var interactor: FavoritesUseCase! { get set }
    
    func viewDidLoad()
    func didSelect(movie: Movie)
    func didUnfavorite(movie: Movie)
    func didTapRemoveFilterButton()
    func didSearchMovies(withTitle title: String)
    func didFinishSearch()
    func didTapFilterButton()
    
}

protocol FavoritesUseCase {
    
    var output: FavoritesInteractorOutput! { get set }
    
    func readFavoriteMovies()
    func removeFilters()
    func searchMovies(withTitle title: String)
    func unfavorite(movie: Movie)
    
}

protocol FavoritesInteractorOutput {
    
    func didRead(movies: [Movie])
    func didSearchMovies(withTitle title: String, _ movies: [Movie])
    
}

protocol FavoritesWireframe {
    
    var view: UIViewController? { get set }
    
    func presentMovieDetailsFor(_ movie: Movie)
    func presentFiltersView()
    
    static func assembleModule() -> UIViewController
    
}
