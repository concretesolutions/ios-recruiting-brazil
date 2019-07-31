//
//  ListMoviesRouter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 25/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

class ListMoviesRouter: ListMoviesWireframe {
    
    //MARK: - Properties
    var viewController: UIViewController?
    
    //MARK: - Contract Functions
    func presentMovieDescription(movie: MovieEntity, genres: [GenreEntity], poster: PosterEntity?) {
        let movieDescriptionViewController = MovieDescriptionRouter.assembleModule(movie: movie, genres: genres, poster: poster)
        viewController?.navigationController?.pushViewController(movieDescriptionViewController, animated: true)
    }
    
    func presentFavoriteMovies() { }
    
    static func assembleModule() -> UIViewController {
        let view: ListMoviesViewController?
        view = UIStoryboard(name: "ListMovies", bundle: nil).instantiateViewController(withIdentifier: "ListMovies") as? ListMoviesViewController
        
        let presenter = ListMoviesPresenter()
        let interactor = ListMoviesInteractor()
        let router = ListMoviesRouter()
        
        let navigation = UINavigationController(rootViewController: view!)
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.barTintColor = ColorPalette.yellow.uiColor
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigation
    }
    
}
