//
//  MovieGridViewModel.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//
import UIKit


//MARK: - Interface
protocol MovieGridInterface: class{
    var pageCount: Int {get set}
    var movies: [PresentableMovieInterface] {get set}
    func loadMovies()
    func checkFavorite(movieID: Int) -> Bool
}


//MARK: - Init
class MovieGridViewModel{
    public var pageCount = 0
    weak var refresh: MovieGridViewModelDelegate?
    var crud: FavoriteCRUDInterface
    var apiAccess: APIClientInterface
    
    
    var movies: [PresentableMovieInterface] = [] {
        didSet{
            refresh?.refreshMovieData()
        }
    }
    
    init(crud: FavoriteCRUDInterface, apiAccess: APIClientInterface) {
        self.crud = crud
        self.apiAccess = apiAccess
        loadMovies()
    }
}


//MARK: - Methods
extension MovieGridViewModel: MovieGridInterface{
    
    //Loads the movie banner from the api
    func loadImage(path: String, completion: @escaping (UIImage) -> Void ){
        apiAccess.downloadImage(path: path) { (fetchedImage) in
            if let image = fetchedImage{
                completion(image)
            }
        }
    }
    
    //Loads the movies from the API
    func loadMovies(){
        pageCount += 1
        var tempImage = UIImage()
        apiAccess.fetchData(path: ApiPaths.movies(page: pageCount), type: Populares.self) { [weak self] (fetchedMovies,error) in
            guard let checkMovies = fetchedMovies.results else {fatalError("Error fetching the movies form the API")}
    
            if error == nil {
                checkMovies.forEach({ (movie) in
                    if let path = movie.poster_path{
                        self?.loadImage(path: path, completion: { [weak self] (image) in
                            tempImage = image
                            self?.movies.append(SimplifiedMovie(movieID: movie.id, movieTitle: movie.title, movieOverview: movie.overview, movieGenres: movie.genre_ids, movieDate: movie.release_date, image: tempImage))
                            
                        })
                    }
                })
            }else{
                self?.movies = []
            }
        }
    }
    
    //Check if a movie is a favorite to display in the grid
    func checkFavorite(movieID: Int) -> Bool{
        let isFavorite = crud.checkFavoriteMovie(movieId: "\(movieID)")
        return isFavorite
    }
}
