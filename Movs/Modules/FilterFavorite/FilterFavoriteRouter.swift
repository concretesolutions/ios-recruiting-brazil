//
//  FilterFavoriteRouter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class FilterFavoriteRouter: FilterFavoriteWireframe {
    
    //MARK: - Contract Properties
    var viewController: UIViewController?
    
    //MARK: - Contract Functions
    func presentFilteredFavoriteMovies(filters: Dictionary<String, String>) {
        
        let views = viewController?.navigationController?.viewControllers
        if let view = views?[views!.count - 2] as? FavoriteMoviesViewController {
            view.presenter.filters = filters
        }
        viewController?.navigationController?.popViewController(animated: true)
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
