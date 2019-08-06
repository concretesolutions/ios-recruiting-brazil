//
//  FilterFavoritePresenter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

final class FilterFavoritePresenter: FilterFavoritePresentation {
    
    //MARK: - Contract Properties
    weak var view: FilterFavoriteView?
    var router: FilterFavoriteWireframe!

    var movies: [MovieEntity]?
    
    //MARK: - Contract Functions
    func viewDidLoad() {
        view?.showAvaliableFilters(movies: self.movies!)
    }
    
    func didEnterFilters(_ filter: Dictionary<String, String>) {
        let movies = filterMovies(filters: filter)
        router.presentFilteredFavoriteMovies(filteredMovies: movies)
    }
    
    //MARK: - Functions
    private func filterMovies(filters: Dictionary<String, String>) -> [MovieEntity] {
        
        let movies = UserSaves.favoriteMovies
        
        // Values to search in movies
        var date = ""
        var genreName = ""
        for (key, value) in filters {
            if key == "Date" {
                date = value
            }
            else {
                genreName = value
            }
        }
        
        var filteredMovies: [MovieEntity] = []
        
        if genreName != "" && date != "" {
            filteredMovies = filterMoviesWithGenreAndDate(movies: movies, genreName: genreName, date: date)
        }
        else if genreName != "" && date == ""  {
            filteredMovies = filterMoviesWithGenre(movies: movies, genreName: genreName)
        }
        else if  genreName == "" && date != "" {
            filteredMovies = filterMoviesWithDate(movies: movies, date: date)
        }
        
        return filteredMovies

    }
    
    private func filterMoviesWithGenreAndDate(movies: [MovieEntity], genreName: String, date: String) -> [MovieEntity] {
        var filteredMovies: [MovieEntity] = []
        
        for (index, item) in movies.enumerated() {
            var genres: [GenreEntity] = []
            if let genreIds = item.genresIds {
                genres = GenreEntity.gatherMovieGenres(genresIds: genreIds)
            }
            
            if genres.contains(where: { (genre) -> Bool in
                genre.name == genreName
            }) {
                filteredMovies.append(item)
            }
            if !(item.formatDateString() == date) {
                filteredMovies.remove(at: index)
            }
        }
        
        return filteredMovies
    }
    
    private func filterMoviesWithGenre(movies: [MovieEntity], genreName: String) -> [MovieEntity] {
        var filteredMovies: [MovieEntity] = []

        for item in movies {
            
            var genres: [GenreEntity] = []
            if let genreIds = item.genresIds {
                genres = GenreEntity.gatherMovieGenres(genresIds: genreIds)
            }
            if genres.contains(where: { (genre) -> Bool in
                genre.name == genreName
            }) {
                filteredMovies.append(item)
            }
        }
        
         return filteredMovies
    }
    
    private func filterMoviesWithDate(movies: [MovieEntity], date: String) -> [MovieEntity] {
        var filteredMovies: [MovieEntity] = []
        for item in movies {
            if item.formatDateString() == date {
                filteredMovies.append(item)
            }
        }
        
        return filteredMovies
    }

    
}

//for item in posters! {
//    if let movieId = item.movieId {
//        if favoriteMovies!.contains(where: { (movie) -> Bool in
//            movie.id == movieId
//        }) {
//            filteredPosters.append(item)
//        }
//    }
//}
