//
//  DetailMovieViewModel.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain
final class DetailMovieVCModel: NSObject {
	private let cachedGenresUseCase: Domain.CachedGenresUseCase
	private let favoriteMoviesUseCase: Domain.FavoriteMoviesUseCase
	
	private var movie: Movie
	private var favorite: Bool
	
	init(cachedGenresUseCase: Domain.CachedGenresUseCase, favoriteMoviesUseCase: Domain.FavoriteMoviesUseCase, movie: Movie = MoviePlaceholder.model1(), favorite: Bool = false) {
		self.cachedGenresUseCase = cachedGenresUseCase
		self.favoriteMoviesUseCase = favoriteMoviesUseCase
		self.movie = movie
		self.favorite = favorite
	}
	
	public func provideDetailedMetadata(handler: @escaping (Movie?, [Genre]?, Bool, Error?) -> ())  {
		cachedGenresUseCase.fetchCachedGenres(with: movie.genreIDs) { (genres, error) in
			
			if let genres = genres {
				handler(self.movie, genres, self.favorite, nil)
			} else {
				print(error?.localizedDescription ?? "")
				handler(nil, nil, false, error)
			}
		}
	}
	
	private func addFavorite() {
		favoriteMoviesUseCase.addFavorite(object: self.movie)
	}
	
	private func deleteFavorite() {
		favoriteMoviesUseCase.deleteFavorite(object: self.movie)
	}
	
	func toggleFavorite() -> Bool{
		favorite.toggle()
		if favorite == true {
			addFavorite()
		} else {
			deleteFavorite()
		}
		return favorite
	}
}
