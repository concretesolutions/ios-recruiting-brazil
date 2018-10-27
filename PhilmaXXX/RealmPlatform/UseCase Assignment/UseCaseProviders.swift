//
//  FavoriteMoviesUseCaseProvider.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

public final class FavoriteMoviesUseCaseProvider: Domain.FavoriteMoviesUseCaseProvider {
	
	public init() { }
	
	public func useCase() -> Domain.FavoriteMoviesUseCase {
		let repository = FavoritesRepository(realm: try! Realm())
		return FavoriteMoviesUseCase(repository: repository)
	}	
}

public final class SetupUseCaseProvider: Domain.SetupUseCaseProvider {
	
	public init() { }
	
	public func useCase() -> Domain.SetupUseCase {
		let repository = GenresRepository(realm: try! Realm())
		return SetupUseCase(repository: repository)
	}
	
}

public final class CachedGenresUseCaseProvider: Domain.CachedGenresUseCaseProvider {
	
	public init() { }
	
	public func useCase() -> Domain.CachedGenresUseCase {
		let repository = GenresRepository(realm: try! Realm())
		return CachedGenresUseCase(repository: repository)
	}
	
}
