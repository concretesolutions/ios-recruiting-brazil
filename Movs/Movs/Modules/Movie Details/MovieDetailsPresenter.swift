//
//  MovieDetailsPresenter.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 14/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MovieDetailsPresenter: NSObject {
    
    // MARK: - VIPER
    var view: MovieDetailsView
    var interactor: MovieDetailsInteractor
    var router: MovieDetailsRouter
    
    init(router: MovieDetailsRouter, interactor: MovieDetailsInteractor, view: MovieDetailsView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        
        self.interactor.presenter = self
        self.view.presenter = self
    }
    
    // MARK: - FROM VIEW
    
    func loadMovie() {
        self.interactor.fetchMovie()
    }
    
    func favorite() {
        self.interactor.addToFavorite()
    }
    
    func removeFavorite() {
        self.interactor.removeFavorite()
    }
    
    // MARK: - FROM INTERACTOR
    
    func movieLoaded(title: String, favorite: Bool, genre: [Genre], year: String, overview: String, imageURL: String) {
        
        var movieGenre = ""
        if !genre.isEmpty {
            for g in genre {
                if g.name == genre.last?.name {
                    movieGenre.append(g.name!)
                }else{
                    movieGenre.append(g.name! + ", ")
                }
            }
        }
        
        let movieYear = String(year.prefix(4))
        let movieFavorite = self.interactor.favorite()
        
        self.view.setMovie(title: title, favorite: movieFavorite, genre: movieGenre, year: movieYear, overview: overview, imageURL: imageURL)
    }
    
}
