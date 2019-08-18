//
//  MovieGridViewModel.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//
import UIKit


protocol MovieGridInterface{
    var pageCount: Int {get set}
    var movies: [SimplifiedMovie] {get set}
    
    func loadMovies()
    func checkFavorite(movieID: Int) -> String
}


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


//MARK: - Focus on the apresentation of the movies in the API
extension MovieGridViewModel: MovieGridInterface{
    
    //Loads the movie banner from the api
    func loadImage(path: String, completion: @escaping (UIImage) -> Void ){
        APIController.sharedAccess.downloadImage(path: path) { (fetchedImage) in
            if let image = fetchedImage{
                completion(image)
            }
        }
    }
    
    //Loads the movies from the API
    func loadMovies(){
        pageCount += 1
        var tempImage = UIImage()
        
        APIController.sharedAccess.fetchData(path: ApiPaths.movies(page: pageCount), type: Populares.self) { [weak self] (fetchedMovies,error) in
            guard let checkMovies = fetchedMovies.results else {fatalError("Error fetching the movies form the API")}
            checkMovies.forEach({ (movie) in
                if let path = movie.poster_path{
                    self?.loadImage(path: path, completion: { [weak self] (image) in
                        tempImage = image
                        self?.movies.append(SimplifiedMovie(movieID: movie.id, movieTitle: movie.title, movieOverview: movie.overview, movieGenres: movie.genre_ids, movieDate: movie.release_date, image: tempImage))
                    
                    })
                }
            })
        }
    }
    
    //Check if a movie is a favorite to display in the grid
    func checkFavorite(movieID: Int) -> String{
        let isFavorite = FavoriteCRUD.sharedCRUD.checkFavoriteMovie(movieId: "\(movieID)")
        if isFavorite{
            return "favorite_gray_icon"
        }else{
            return "favorite_empty_icon"
        }
    }
}
