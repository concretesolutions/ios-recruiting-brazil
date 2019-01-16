//
//  FavoriteMoviesUseCase.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

public final class FavoriteMoviesUseCase: Domain.FavoriteMoviesUseCase {
	let repository: FavoritesRepository
	
	public init(repository: FavoritesRepository) {
		self.repository = repository
	}
	
	public func fetchFavorites(handler: @escaping (Result<[Movie]>) -> ()) {
		handler(Result<[Movie]>.success(self.repository.get()))
	}
	
	public func addFavorite(object: Movie){
		self.repository.upsert(object: object)
	}
	
	public func deleteFavorite(object: Movie){
		self.repository.delete(object: object)
	}

}
