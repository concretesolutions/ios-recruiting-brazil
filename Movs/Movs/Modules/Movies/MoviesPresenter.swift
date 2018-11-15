//
//  MoviesPresenter.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesPresenter: NSObject {
    
    // MARK: - VIPER
    var view: MoviesView
    var interactor: MoviesInteractor
    var router: MoviesRouter
    
    init(router: MoviesRouter, interactor: MoviesInteractor, view: MoviesView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        
        self.interactor.presenter = self
        self.view.presenter = self
    }
    
    // FROM VIEW
    
    func selectedMovie(at index: Int) {
        let id = self.interactor.getMovieID(index: index)
        self.router.goToMovieDetail(movieID: id)
    }
    
    func fetchMovies() {
        self.interactor.fetchMovies()
    }
    
    func totalMovies() -> Int {
        return self.interactor.getTotalMovies()
    }
    
    func searchMovie(containing: String) {
        self.interactor.filterMovies(containing: containing)
    }
    
    func searchMovieEnded() {
        self.interactor.filterMoviesEnded()
    }
    
    // FROM INERACTOR
    
    func loadedMovies() {
        self.view.showPopularMovies()
    }
    
    func loadingError() {
        self.view.showError()
    }
    
    func moviesFilterChanged() {
        self.view.showPopularMovies()
    }
    
    func noResults() {
        self.view.showNoResults()
    }
    
}

// MARK: - UICollectionViewDataSource
extension MoviesPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.getTotalMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Prepare cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        // Get movie
        let movie = self.interactor.getMovie(at: indexPath.item)
        cell.awakeFromNib(title: movie.title, favorite: self.interactor.favorite(index: indexPath.item))
        // Load image
        if let image = movie.poster_path {
            let imageURL = ServerURL.imageW500 + image
            cell.setup(imageURL: imageURL)
        }
        return cell
    }
    
}
