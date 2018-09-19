//
//  ListFavoritesInteractor.swift
//  Movs
//
//  Created by Lucas Ferraço on 19/09/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListFavoritesBusinessLogic {
	func getFavorites()
}

protocol ListFavoritesDataStore {
	//var name: String { get set }
}

class ListFavoritesInteractor: ListFavoritesBusinessLogic, ListFavoritesDataStore {
	var presenter: ListFavoritesPresentationLogic?
	var worker: ListFavoritesWorker?
	
	var favorites: [Movie] = []
	
	// MARK: Get Favorites
	
	func getFavorites() {
		var success = true
		
		worker = ListFavoritesWorker()
		if let fetchedFavs = worker?.fetchFavorites(ofType: Movie.self) {
			favorites = fetchedFavs
		} else {
			success = false
		}
		
		let moviesInfo: [ListFavorites.MovieInfo]? = favorites.map(self.getResponseMovieInfo)
		let response = ListFavorites.GetFavorites.Response(isSuccess: success, movies: moviesInfo)
		presenter?.presentFavorites(with: response)
	}
	
	// MARK: Auxiliary methods
	
	private func getResponseMovieInfo(from movie: Movie) -> ListFavorites.MovieInfo {
		// The poster image is preferable to the backdrop image
		var image: Data? = nil
		if let posterData = movie.posterImageData {
			image = posterData
		} else if let backdropImage = movie.backdropImageData {
			image = backdropImage
		}
		
		return ListFavorites.MovieInfo(id: movie.id, title: movie.title, image: image, genres: movie.genres, releaseDate: movie.releaseDate, overview: movie.overview)
	}
}
