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
//        if let image = movie.poster_path {
//            let imageURL = ServerURL.imageW500 + image
//            cell.setup(imageURL: imageURL)
//        }
        return cell
    }
}

