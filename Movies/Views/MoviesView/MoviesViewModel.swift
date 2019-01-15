//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/10/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewModel: RequestDelegate{
    
    let requestMaker = RequestMaker()
    var controller: MoviesViewController
    var moviesArray = [MovieModel]()
    var pageToRequest: Int = 1
    
    init(viewController: MoviesViewController){
        controller = viewController
        
        self.requestMaker.delegate = self
        self.requestMaker.requestPopular(pageToRequest: self.pageToRequest)
        self.controller.isLoadingData = true
        self.requestMaker.requestGenres()
    }
    
    func didLoadPopularMovies(movies: [MovieModel]) {
        self.requestMaker.requestImages(forMovies: movies)
    }
    
    func didLoadPopularMoviesWithThumbnail(movies: [MovieModel]) {
        if (moviesArray.count == 0){
            self.moviesArray = movies
        } else {
            self.moviesArray.append(contentsOf: movies)
        }
        controller.didLoadPopularMovies()
    }
    
    func didFailToLoadPopularMovies(withError error: Error) {
        print("Failed to load popular movies with error: \(error.localizedDescription)")
        controller.failedToLoad(withType: "Popular Movies")
    }
    
    func didFailToLoadGenres(withError error: Error) {
        print("Faile to load movie genres:\(error.localizedDescription)")
        controller.failedToLoad(withType: "Movie Genres")
    }
    
    func loadImage(forMovie movie:MovieModel, completion: @escaping (_ image: UIImage) -> Void){
        requestMaker.requestImage(imagePath: movie.thumbnailPath) { (newThumbnail) in
            completion(newThumbnail)
        }
    }
    
    func requestMoreMovies() {
        pageToRequest = pageToRequest + 1
        self.requestMaker.requestPopular(pageToRequest: pageToRequest)
    }
}
