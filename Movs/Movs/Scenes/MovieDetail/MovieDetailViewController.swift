//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MovieDetailViewPresenter: PresenterProtocol {
    func didFavoriteMovie()
    func didUnfavoriteMovie()
}

final class MovieDetailViewController: MVPBaseViewController {
    
    private var movieDetailView:MovieDetailView! {
        didSet {
            self.movieDetailView.setupView()
            self.view = self.movieDetailView
        }
    }
    
    var presenter: MovieDetailViewPresenter? {
        get {
            return self.basePresenter as? MovieDetailViewPresenter
        }
        set {
            self.basePresenter = newValue
        }
    }
}

extension MovieDetailViewController: MovieDetailPresenterView {
    
    func setupOnce() {
        self.title = "Movie"
        self.movieDetailView = MovieDetailView()
    }
    
    func present(movieDetail: MovieDetail) {
        self.movieDetailView.movieDetail = movieDetail
    }
}

extension MovieDetailViewController: MovieDetailViewDelegate {
    
    func didFavoriteMovie(at sender: MovieDetailView) {
        self.presenter?.didFavoriteMovie()
    }
    
    func didUnfavoriteMovie(at sender: MovieDetailView) {
        self.presenter?.didUnfavoriteMovie()
    }
}
