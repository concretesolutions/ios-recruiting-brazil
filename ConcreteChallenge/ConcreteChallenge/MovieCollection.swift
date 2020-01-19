//
//  MovieCollection.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

protocol MovieCollectionDelegate: class {
    func reload()
    func failToFetch()
}

class MovieColletion {
    
    weak var delegate: MovieCollectionDelegate?
    
    private var userDefaults = UserDefaults.standard
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    private var favoriteMovies: [FavoriteMovie] {
        get {
            return CoreDataHelper.retrieveFavoriteMovies()
        }
    }
    
    var count: Int {
        get {
            return movies.count
        }
    }
    
    var countFilteredMovies: Int {
        return filteredMovies.count
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = movies.filter { (movie: Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        
        delegate?.reload()
    }
    
    func filteredMovie(at index: Int) -> Movie? {
        return filteredMovies[safeIndex: index]
    }
    
    func getFavorites() -> [Movie] {
        var movies = [Movie]()
        
        for favorite in favoriteMovies {
            movies.append(contentsOf: self.movies.filter { $0.id == Int(favorite.id) })
        }
        
        return movies
    }
    
    func movie(at index: Int) -> Movie? {
        return movies[safeIndex: index]
    }
    
    func requestMovies() {
        let currentPage = userDefaults.integer(forKey: UserDefaultsConstants.currentPage)
        
        ServiceLayer.request(router: .getMovies) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                self.userDefaults.set(currentPage + 1, forKey: UserDefaultsConstants.currentPage)
                self.movies.append(contentsOf: response.results)
                self.delegate?.reload()
            case .failure:
                self.delegate?.failToFetch()
            }
        }
    }
    
    func updateState(for movie: Movie) {
        if let movie = CoreDataHelper.favoriteMovie(for: movie.id) {
            CoreDataHelper.delete(favoriteMovie: movie)
        } else {
            let favoriteMovie = CoreDataHelper.newFavoriteMovie()
            
            favoriteMovie.id = Int64(movie.id)
            favoriteMovie.title = movie.title
            favoriteMovie.releaseDate = movie.releaseDate
            favoriteMovie.overview = movie.overview
            favoriteMovie.voteAverage = movie.voteAverage
            
            CoreDataHelper.save()
        }
    }
}
