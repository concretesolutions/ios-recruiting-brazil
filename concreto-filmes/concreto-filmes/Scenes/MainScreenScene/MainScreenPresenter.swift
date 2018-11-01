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
    var realm = RealmService.shared.realm

    func present(movies: [Movie]?) {
        DispatchQueue.main.async {
            var viewModelItems: [MainScreen.ViewModel.MovieViewModel] = []
            if let movies = movies {
                for movie in movies {
                    let isFavorite = self.realm?.object(ofType: MovieRealm.self, forPrimaryKey: movie.id) != nil
                    viewModelItems.append(MainScreen.ViewModel.MovieViewModel(posterUrl: movie.posterPath, title: movie.title, isFavorite: isFavorite))
                }
                self.viewController?.display(movies: viewModelItems)
            }
        }
    }
    
//    private func checkFavoriteMovie(movie: Movie) -> Bool{
//        return realm?.objects(FavoriteMovie.self).
//    }

    func present(error: String?) {
        if let error = error {
            DispatchQueue.main.sync {
                viewController?.displayAlert(title: "OPS!", message: error)
            }
        }
    }
}
