//
//  MainScreenPresenter.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 23/10/18.
//  Copyright (c) 2018 Leonel Menezes. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainScreenPresentationLogic {
    func present(movies: [Movie]?)
    func present(error: String?)
}

class MainScreenPresenter: MainScreenPresentationLogic {
    weak var viewController: MainScreenDisplayLogic?

    func present(movies: [Movie]?) {
        var viewModelItems: [MainScreen.ViewModel.MovieViewModel] = []
        if let movies = movies {
            for movie in movies {
                viewModelItems.append(MainScreen.ViewModel.MovieViewModel(posterUrl: movie.posterPath ?? "", title: movie.title))
            }
            viewController?.display(movies: viewModelItems)
        }
    }

    func present(error: String?) {
        if let error = error {
            DispatchQueue.main.sync {
                viewController?.displayAlert(title: "OPS!", message: error)
            }
        }
    }
}
