//
//  ListMoviesPresenter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 24/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

class ListMoviesPresenter: ListMoviesPresentation {
    
    //MARK: - Contract Properties
    weak var view: ListMoviesView?
    var interactor: ListMoviesUseCase!
    var router: ListMoviesWireframe!
    
    //MARK: - Properties
    var movies: [MovieEntity] = [] {
        didSet {
            if movies.count > 0 {
                view?.showMoviesList(movies)
                interactor.fetchPosters(movies: movies)
            }
            else {
                view?.showNoContentScreen(image: UIImage(named: "search_icon"), message: "No movie found on API")
            }
        }
    }

    var posters: [PosterEntity] = [] {
        didSet {
            view?.updatePosters(posters)
        }
    }
    
    //MARK: - Contract Functions
    func viewDidLoad() {
        interactor.fetchGenres()
        interactor.fetchMovies()
    }
    
    func didEnterSearch(_ search: String) {
        if !search.isEmpty {
            let filteredMovies = movies.filter { (movie) -> Bool in
                if (movie.title?.contains(search))! {
                    return true
                }
                return false
            }
            if filteredMovies.count > 0 {
                view?.showMoviesList(filteredMovies)
            }
            else {
                view?.showNoContentScreen(image: UIImage(named: "search_image"), message: "Your search '\(search)' didn't find any results.")
            }
        }
        else {
            view?.showMoviesList(movies)
        }
    }
    
    func didSelectMovie(_ movie: MovieEntity) {
        
        let posterToSend = posters.first { (image) -> Bool in
            image.movieId == movie.id
        }
        router.presentMovieDescription(movie: movie, genres: GenreEntity.gatherMovieGenres(genresIds: movie.genresIds!), poster: posterToSend)
    }
    
}

//MARK: -
extension ListMoviesPresenter: ListMoviesInteractorOutput {
    
    //MARK: - Contract Functions
    func fetchedGenres(_ genres: GenresEntity) {
        GenresEntity.setAllGenres(genres.genres)
    }
    
    func fetchedGenresFailed() { }
    
    func fetchedMovies(_ movies: [MovieEntity]) {
        self.movies.append(contentsOf: movies)
    }
    
    func fetchedMoviesFailed() {
        view?.showNoContentScreen(image: nil, message: "Failed to gather movies from API. Please try again later.")
    }
    
    func fetchedPoster(_ poster: PosterEntity) {
        self.posters.append(poster)
    }
    
    func fetchedPosterFailed() { }

}
