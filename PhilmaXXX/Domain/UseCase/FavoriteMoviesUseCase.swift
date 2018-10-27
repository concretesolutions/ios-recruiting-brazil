//
//  FavoriteMoviesUseCase.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

public protocol FavoriteMoviesUseCase {
	func fetchFavorites(handler: @escaping ([Movie]?, Error?) -> ())
	func addFavorite(object: Movie)
	func deleteFavorite(object: Movie)
}
