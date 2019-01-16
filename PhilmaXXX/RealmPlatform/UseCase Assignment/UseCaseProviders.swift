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

public final class EnvironmentSetupUseCaseProvider: Domain.EnvironmentSetupUseCaseProvider {
	
	public init() { }
	
	public func useCase() -> Domain.EnvironmentSetupUseCase {
		let repository = GenresRepository(realm: try! Realm())
		return EnvironmentSetupUseCase(repository: repository)
	}
	
}

public final class FilterUseCaseProvider: Domain.FilterUseCaseProvider {
	
	public init() { }
	
	public func useCase() -> Domain.FilterUseCase {
		let repository = GenresRepository(realm: try! Realm())
		return FilterUseCase(repository: repository)
	}
	
}
