//
//  FilterFavoritePresenter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class FilterFavoritePresenter: FilterFavoritePresentation {
    
    //MARK: - Contract Properties
    weak var view: FilterFavoriteView?
    var router: FilterFavoriteWireframe!

    var movies: [MovieEntity]?
    
    //MARK: - Contract Functions
    func viewDidLoad() {
        view?.showAvaliableFilters(movies: self.movies!)
    }
    
    func didEnterFilters(_ filter: Dictionary<String, String>) {
        router.presentFilteredFavoriteMovies(filters: filter)
    }
    
}
