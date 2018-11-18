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
    
    func hasFilter() -> Bool {
        return self.interactor.hasFilter()
    }
    
    func reloadMovies() {
        self.interactor.reloadMovies()
    }
    
    func fetchFavoriteMovies() {
        self.interactor.fetchFavoriteMovies()
    }
    
    func selectedMovie(at index: Int) {
        // Remove filter
        if self.interactor.hasFilter(){
            if index == 0 {
                self.interactor.filtersEnded()
            }else{
                let id = self.interactor.getMovieID(index: index-1)
                self.router.goToMovieDetail(movieID: id)
            }
        }else{
            let id = self.interactor.getMovieID(index: index)
            self.router.goToMovieDetail(movieID: id)
        }
    }
    
    func searchMovie(containing: String) {
        self.interactor.filterMovies(containing: containing)
    }
    
    func searchMovieEnded() {
        self.interactor.filterMoviesEnded()
    }
    
    func addFilterGenre(with genre: String) {
        self.interactor.addFilterGenre(with: genre)
    }
    func removeFilterGenre(with genre: String) {
        self.interactor.removeFilterGenre(with: genre)
    }
    
    func filterGenreChecked(with genreString: String) -> Bool {
        var checked = false
        for genre in self.interactor.filter.genre! {
            if genre.contains(genreString) {
                checked = true
            }
        }
        return checked
    }
    
    // FROM INTERACTOR
    
    func moviesFilterChanged() {
        self.view.showFavoriteMovies()
    }
    
}

// MARK: - UICollectionViewDataSource
extension FavoritesPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.interactor.hasFilter() {
            return self.interactor.getTotalMovies() + 1
        }
        return self.interactor.getTotalMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.interactor.hasFilter() {
            // Com filtro
            if indexPath.row == 0 {
                // Remove filter
                return self.cellRemoveFilter(tableView: tableView, indexPath: indexPath)
            }else{
                // Outras celulas filmes
                let index = IndexPath.init(row: indexPath.row, section: indexPath.section)
                return self.cellMovie(tableView: tableView, indexPath: index, index: -1)
            }
        }else{
            // Celulas de filmes
            return self.cellMovie(tableView: tableView, indexPath: indexPath, index: 0)
        }
    }
    
    func cellRemoveFilter(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        // Prepare cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "removeFilter", for: indexPath) as! FavoriteMovieCell
        return cell
    }
    
    func cellMovie(tableView: UITableView, indexPath: IndexPath, index: Int) -> UITableViewCell {
        // Prepare cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! FavoriteMovieCell
        // Get movie
        let movie = self.interactor.getMovie(at: indexPath.row + index)
        cell.awakeFromNib(title: movie.title, year: movie.release_date, overview: movie.overview)
        // Load image
        let imageURL = ServerURL.imageW500 + movie.poster_path
        cell.setup(imageURL: imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.interactor.removeFavoriteMovie(at: indexPath.row)
        }
    }
    
}

