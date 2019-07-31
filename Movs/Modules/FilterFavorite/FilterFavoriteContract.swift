//
//  FilterFavoriteContract.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

/**
 VIPER contract to FilterFavorite module
 */

protocol FilterFavoriteView: class {
    var presenter: FilterFavoritePresentation! { get set }
    
    func showAvaliableFilters(movies: [MovieEntity])
    func adjustConstraints()
}

protocol FilterFavoritePresentation: class {
    var view: FilterFavoriteView? { get set }
    var router: FilterFavoriteWireframe! { get set }
    var movies: [MovieEntity]? { get set }
    
    func viewDidLoad()
    func didEnterFilters(_ filter: Dictionary<String, String>)
}

//protocol FilterFavoriteUseCase: class {
//    var output: FilterFavoriteInteractorOutput! { get set }
//
//    //func fetchFavoriteMovies()
//}
//
//protocol FilterFavoriteInteractorOutput: class {
//    func fetchedFavoriteMovies(_ : [MovieEntity])
//    func fetchedFavoriteMoviesFailed()
//}

protocol FilterFavoriteWireframe: class {
    var viewController: UIViewController? { get set }

    func presentFilteredFavoriteMovies(filters: Dictionary<String, String>)
    
    static func assembleModule(movies: [MovieEntity]) -> UIViewController
}


