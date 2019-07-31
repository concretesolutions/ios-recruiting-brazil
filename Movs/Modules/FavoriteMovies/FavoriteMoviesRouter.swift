//
//  FavoriteMoviesRouter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 25/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class FavoriteMoviesRouter: FavoriteMoviesWireframe {
    
    //MARK: - Contract Properties
    weak var viewController: UIViewController?
    
    //MARK: - Contract Functions
    func presentFavoriteMovieDescription(movie: MovieEntity, genres: [GenreEntity], poster: PosterEntity?) {
        let movieDescriptionViewController = MovieDescriptionRouter.assembleModule(movie: movie, genres: genres, poster: poster)
        viewController?.navigationController?.pushViewController(movieDescriptionViewController, animated: true)
    }
    
    func presentMoviesList() { }
    
    func presentFilterSelection(movies: [MovieEntity]) {
        let filterFavoriteViewController = FilterFavoriteRouter.assembleModule(movies: movies)
        viewController?.navigationController?.pushViewController(filterFavoriteViewController, animated: true)
    }
    
    static func assembleModule() -> UIViewController {
        
        let view = UIStoryboard(name: "FavoriteMovies", bundle: nil).instantiateViewController(withIdentifier: "FavoriteMovies") as? FavoriteMoviesViewController
        
        let presenter = FavoriteMoviesPresenter()
        let router = FavoriteMoviesRouter()
        let interactor = FavoriteMoviesInteractor()
        
        let navigation = UINavigationController(rootViewController: view!)
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.barTintColor = ColorPalette.yellow.uiColor
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        router.viewController = view
        
        interactor.output = presenter
        
        return navigation
    }
    
}
