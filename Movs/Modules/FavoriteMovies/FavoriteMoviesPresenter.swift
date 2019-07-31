//
//  FavoriteMoviesPresenter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 25/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class FavoriteMoviesPresenter: FavoriteMoviesPresentation {
    
    //MARK: - Contract Properties
    weak var view: FavoriteMoviesView?
    var interactor: FavoriteMoviesUseCase!
    var router: FavoriteMoviesWireframe!
    
    var filters: Dictionary<String, String>?
    
    //MARK: - Properties
    var favoriteMovies: [MovieEntity]?
    var posters: [PosterEntity]?
    
    //MARK: - Contract Functions
    func viewDidLoad() {
        interactor.fetchFavoriteMovies()
        if filters != nil {
            filterMovies()
            self.view?.isFilterActive = true
        }
    }
    
    func didEnterSearch(_ search: String) {
        if !search.isEmpty {
            let filteredMovies = UserSaves.favoriteMovies.filter { (movie) -> Bool in
                if (movie.title?.contains(search))! {
                    return true
                }
                return false
            }
            let filteredPosters = UserSaves.posters.filter { (poster) -> Bool in
                if filteredMovies.contains(where: { (movie) -> Bool in
                    movie.id == poster.movieId
                }) {
                    return true
                }
                return false
            }
            view?.showFavoriteMoviesList(filteredMovies, posters: filteredPosters)
        }
        else {
            self.view?.showFavoriteMoviesList(UserSaves.favoriteMovies, posters: UserSaves.posters)
        }
    }
    
    func didDeleteFavorite(movie: MovieEntity) {
        UserSaves.favoriteMovies.removeAll { (mov) -> Bool in
            mov.id == movie.id
        }
        UserSaves.posters.removeAll { (post) -> Bool in
            post.movieId == movie.id
        }
        
        if UserSaves.favoriteMovies.count > 0 {
            self.view?.showFavoriteMoviesList(UserSaves.favoriteMovies, posters: UserSaves.posters)
        }
        else {
            self.view?.showNoContentScreen(image: UIImage(named: "favorite_full_icon"), message: "Sorry! You don't have any favorite movies at the moment.")
        }
    }
    
    func didSelectMovie(_ movie: MovieEntity, poster: PosterEntity?) {
        router.presentFavoriteMovieDescription(movie: movie, genres: GenreEntity.gatherMovieGenres(genresIds: movie.genresIds!), poster: poster)
    }
    
    func didPressFilter() {
        router.presentFilterSelection(movies: UserSaves.favoriteMovies)
    }
    
    //MARK: - Functions
    func filterMovies() {
        var date = ""
        var genreName = ""
        if let filters = filters {
            for (key, value) in filters {
                if key == "Date" {
                    date = value
                }
                else {
                    genreName = value
                }
            }
            var filteredMovies: [MovieEntity] = []
            
            for (index, item) in favoriteMovies!.enumerated() {
                
                var genres: [GenreEntity] = []
                if let genreIds = item.genresIds {
                    genres = GenreEntity.gatherMovieGenres(genresIds: genreIds)
                }
                
                // Case genre and date filters aren't empty
                if genreName != "" && date != "" {
                    if genres.contains(where: { (genre) -> Bool in
                        genre.name == genreName
                    }) {
                        filteredMovies.append(item)
                    }
                    if !(item.formatDateString() == date) {
                        filteredMovies.remove(at: index)
                    }
                    
                }
                // Case date filter is empty
                else if genreName != "" && date == "" {
                    if genres.contains(where: { (genre) -> Bool in
                        genre.name == genreName
                    }) {
                        filteredMovies.append(item)
                    }
                }
                // Case genre filter is empty
                else if genreName == "" && date != "" {
                    if item.formatDateString() == date {
                        filteredMovies.append(item)
                    }
                }
            }
            
            var filteredPosters: [PosterEntity] = []
            
            for item in posters! {
                if let movieId = item.movieId {
                    if favoriteMovies!.contains(where: { (movie) -> Bool in
                        movie.id == movieId
                    }) {
                        filteredPosters.append(item)
                    }
                }
            }
            
            view?.showFavoriteMoviesList(filteredMovies, posters: filteredPosters)
        }
    }
    
}

extension FavoriteMoviesPresenter: FavoriteMoviesInteractorOutput {
    
    //MARK: - Contract Functions
    func fetchedFavoriteMovies(_ movies: [MovieEntity], posters: [PosterEntity]) {
        if movies.count > 0 {
            self.favoriteMovies = movies
            self.posters = posters
            self.view?.showFavoriteMoviesList(movies, posters: posters)
        }
        else {
            self.view?.showNoContentScreen(image: UIImage(named: "favorite_full_icon"), message: "Sorry! You don't have any favorite movies at the moment.")
        }
    }
    
    func fetchedFavoriteMoviesFailed() {
        self.view?.showNoContentScreen(image: UIImage(named: "search_icon"), message: "Couldn't load your favorite movies")
    }
    
    
}
