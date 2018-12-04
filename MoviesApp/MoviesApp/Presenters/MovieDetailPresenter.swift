//
//  MovieDetailPresenter.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

protocol MovieDetailViewProtocol: NSObjectProtocol {
    func set(movie: Movie)
}

class MovieDetailPresenter {
    private weak var view: MovieDetailViewProtocol?
    private let movie: Movie
    
    class func initView(with movie: Movie) -> MovieDetailViewController {
        let detailView = MovieDetailViewController.defaultDetailViewController()
        detailView.presenter = MovieDetailPresenter(movie: movie)
        return detailView
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func attach(_ presentedView: MovieDetailViewProtocol) {
        view = presentedView
        view?.set(movie: movie)
    }
    
    func favorite() {
        FavoriteHelper.setFavorite(movie: movie)
    }
    
    func unfavorite() {
        FavoriteHelper.unfavorite(movie: movie)
    }
}
