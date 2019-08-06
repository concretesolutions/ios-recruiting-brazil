//
//  FilterFavoriteRouter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

final class FilterFavoriteRouter: FilterFavoriteWireframe {
    
    //MARK: - Contract Properties
    var viewController: UIViewController?
    
    //MARK: - Contract Functions
    func presentFilteredFavoriteMovies(filteredMovies: [MovieEntity]) {
        viewController?.navigationController?.popViewController(animated: true)
        FavoriteMoviesRouter.favoriteMoviesFiltered(filteredMovies, favoriteView: viewController!)
    }
    
    static func assembleModule(movies: [MovieEntity]) -> UIViewController {
        let view = UIStoryboard(name: "FilterFavorite", bundle: nil).instantiateViewController(withIdentifier: "FilterFavorite") as? FilterFavoriteViewController
        
        let presenter = FilterFavoritePresenter()
        let router = FilterFavoriteRouter()
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.movies = movies
        
        router.viewController = view
        
        return view!
    }
    
}
