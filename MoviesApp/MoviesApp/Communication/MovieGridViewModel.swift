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
    public var movies = [SimplifiedMovie]()
    public var pageCount = 0
    
    init() {
        loadMovies { (hasLoaded) in
            if !hasLoaded {
                fatalError("Error loading movies")
            }
        }
    }
}

//MARK: - Focus on the apresentation of the movies in the API
extension MovieGridViewModel {
    
    //Loads the movies from the API
    func loadMovies(completion: @escaping (Bool) -> Void){
        pageCount += 1
        APIController.sharedAccess.fetchData(path: ApiPaths.movies(page: pageCount), type: Populares.self) { [weak self] (fetchedMovies) in
            guard let checkMovies = fetchedMovies.results else {fatalError("Error fetching the movies form the API")}
            checkMovies.forEach({ (movie) in
                self?.movies.append(SimplifiedMovie(movie: movie))
            })
            completion(true)
        }
    }
}
