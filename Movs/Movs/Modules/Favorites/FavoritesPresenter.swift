//
//  FavoritesPresenter.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FavoritesPresenter: NSObject {
    
    // MARK: - VIPER
    var view: FavoritesView
    var interactor: FavoritesInteractor
    var router: FavoritesRouter
    
    init(router: FavoritesRouter, interactor: FavoritesInteractor, view: FavoritesView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        
        super.init()
        
        self.interactor.presenter = self
        self.view.presenter = self
    }
    
    // FROM VIEW
    
    func fetchFavoriteMovies() {
        self.interactor.fetchFavoriteMovies()
    }
    
    func selectedMovie(at index: Int) {
        let id = self.interactor.getMovieID(index: index)
        self.router.goToMovieDetail(movieID: id)
    }
    
    func searchMovie(containing: String) {
        self.interactor.filterMovies(containing: containing)
    }
    
    func searchMovieEnded() {
        self.interactor.filterMoviesEnded()
    }
    
    // FROM INTERACTOR
    
    func moviesFilterChanged() {
        self.view.showFavoriteMovies()
    }
    
}

// MARK: - UICollectionViewDataSource
extension FavoritesPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.getTotalMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Prepare cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! FavoriteMovieCell
        // Get movie
        let movie = self.interactor.getMovie(at: indexPath.row)
        cell.awakeFromNib(title: movie.title, year: movie.release_date, overview: movie.overview)
        // Load image
        let imageURL = ServerURL.imageW500 + movie.poster_path
        cell.setup(imageURL: imageURL)
        return cell
    }
}

