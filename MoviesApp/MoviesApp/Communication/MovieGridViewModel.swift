//
//  MovieGridViewModel.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//
import UIKit


//MARK: - The connecetion of the MovieGrid screen
//The head of the class
class MovieGridViewModel{
    public var pageCount = 0
    weak var refresh: ReturnMovies?
    
    var movies: [SimplifiedMovie] = [] {
        didSet{
            refresh?.refreshMovieData()
        }
    }
    
    init() {
        loadMovies()
    }
}


protocol MovieGridViewInterface {
    
}

//MARK: - Focus on the apresentation of the movies in the API
extension MovieGridViewModel {
    
    //Loads the movies from the API
    func loadMovies(){
        pageCount += 1
        var tempMovies = [SimplifiedMovie]()
        
        APIController.sharedAccess.fetchData(path: ApiPaths.movies(page: pageCount), type: Populares.self) { [weak self] (fetchedMovies,error) in
            guard let checkMovies = fetchedMovies.results else {fatalError("Error fetching the movies form the API")}
            checkMovies.forEach({ (movie) in
                
                tempMovies.append(SimplifiedMovie(movieID: movie.id, movieTitle: movie.title, movieOverview: movie.overview, movieGenres: movie.genre_ids, movieDate: movie.release_date, posterPath: movie.poster_path))
                
            })
            self?.movies.append(contentsOf: tempMovies)
        }
    }
    
    //Check if a movie is a favorite to display in the grid
    func checkFavorite(movieID: Int) -> String{
        let isFavorite = FavoriteCRUD.sharedCRUD.checkFavoriteMovies(movieId: "\(movieID)")
        if isFavorite{
            return "favorite_gray_icon"
        }else{
            return "favorite_empty_icon"
        }
    }
}
