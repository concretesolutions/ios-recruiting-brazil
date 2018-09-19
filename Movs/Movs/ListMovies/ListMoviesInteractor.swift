//
//  ListMoviesInteractor.swift
//  Movs
//
//  Created by Lucas Ferraço on 15/09/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListMoviesBusinessLogic {
	func getMovies()
	func getImage(forMovieId movieId: Int, _ completion: @escaping (UIImage) -> Void)
}

protocol ListMoviesDataStore {
}

class ListMoviesInteractor: ListMoviesBusinessLogic, ListMoviesDataStore {
	var presenter: ListMoviesPresentationLogic?
	var worker = ListMoviesWorker()
	
	// MARK: Auxiliary variables
	
	var movies: [Movie] = []
	
	// MARK: Get Movies
	
	func getMovies() {
		worker.downloadPopularMovies({ (success, returnedMovies: [Movie]?, error)  in
			if let returnedMovies = returnedMovies {
				self.movies = returnedMovies
			}
			let moviesInfo: [ListMovies.MovieInfo]? = returnedMovies?.map(self.getResponseMovieInfo)
			
			let response = ListMovies.GetMovies.Response(isSuccess: success, error: error, movies: moviesInfo)
			self.presenter?.presentMovies(with: response)
		})
	}
	
	//MARK: Get Movie Image
	
	func getImage(forMovieId movieId: Int, _ completion: @escaping (UIImage) -> Void) {
		worker.getImageForMovie(withId: movieId) { (result) in
			if let data = result.imageData, let image = self.presenter?.mountMovieImage(from: data) {
				completion(image)
			}
		}
	}
	
	// MARK: Auxiliary methods
	
	private func getResponseMovieInfo(from movie: Movie) -> ListMovies.MovieInfo {
		// The poster image is preferable to the backdrop image
		var image: Data? = nil
		if let posterData = movie.posterImageData {
			image = posterData
		} else if let backdropImage = movie.backdropImageData {
			image = backdropImage
		}
		
		return ListMovies.MovieInfo(id: movie.id, title: movie.title, image: image, genres: movie.genres, releaseDate: movie.releaseDate)
	}
}
