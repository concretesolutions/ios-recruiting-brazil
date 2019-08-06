//
//  FavoriteMoviesPresenter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 25/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

final class FavoriteMoviesPresenter {
    
    //MARK: - Contract Properties
    weak var view: FavoriteMoviesView?
    var interactor: FavoriteMoviesUseCase!
    var router: FavoriteMoviesWireframe!
    
    var filteredMovies: [MovieEntity] = [] /*{
        didSet {
            view?.showFavoriteMoviesList(filteredMovies, posters: posters!, isFilterActive: true)
        }
    }*/
    
    //MARK: - Properties
    var favoriteMovies: [MovieEntity] = []
    var posters: [PosterEntity] = []
    
}

//MARK: - Contract Functions
extension FavoriteMoviesPresenter: FavoriteMoviesPresentation {
    
    func viewDidLoad() {
        if filteredMovies.count > 0 {
            view?.showFavoriteMoviesList(filteredMovies, posters: posters, isFilterActive: true)
        }
        else {
            interactor.fetchFavoriteMovies()
        }
    }
    
    func didEnterSearch(_ search: String) {
        if !search.isEmpty {
            let filteredMovies = favoriteMovies.filter { (movie) -> Bool in
                if (movie.title?.contains(search))! {
                    return true
                }
                return false
            }
            let filteredPosters = posters.filter { (poster) -> Bool in
                if filteredMovies.contains(where: { (movie) -> Bool in
                    movie.id == poster.movieId
                }) {
                    return true
                }
                return false
            }
            view?.showFavoriteMoviesList(filteredMovies, posters: filteredPosters, isFilterActive: false)
        }
        else {
            self.view?.showFavoriteMoviesList(favoriteMovies, posters: posters, isFilterActive: false)
        }
    }
    
    func didDeleteFavorite(movie: MovieEntity) {
        interactor.removeFavoriteMovie(movie: movie, withPoster: true)
        interactor.fetchFavoriteMovies()
        
        if favoriteMovies.count > 0 {
            self.view?.showFavoriteMoviesList(favoriteMovies, posters: posters, isFilterActive: false)
        }
        else {
            self.view?.showNoContentScreen(image: UIImage(named: "favorite_full_icon"), message: "Sorry! You don't have any favorite movies at the moment.")
        }
    }
    
    func didSelectMovie(_ movie: MovieEntity, poster: PosterEntity?) {
        router.presentFavoriteMovieDescription(movie: movie, genres: GenreEntity.gatherMovieGenres(genresIds: movie.genresIds!), poster: poster)
    }
    
    func didPressFilter() {
        router.presentFilterSelection(movies: favoriteMovies)
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesInteractorOutput {
    
    //MARK: - Contract Functions
    func fetchedFavoriteMovies(_ movies: [MovieEntity], posters: [PosterEntity]) {
        if movies.count > 0 {
            self.favoriteMovies = movies
            self.posters = posters
            self.view?.showFavoriteMoviesList(movies, posters: posters, isFilterActive: false)
        }
        else {
            self.view?.showNoContentScreen(image: UIImage(named: "favorite_full_icon"), message: "Sorry! You don't have any favorite movies at the moment.")
        }
    }
    
    func fetchedFavoriteMoviesFailed() {
        self.view?.showNoContentScreen(image: UIImage(named: "search_icon"), message: "Couldn't load your favorite movies")
    }
    
    
}
