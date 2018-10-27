//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

public protocol StartupUseCaseProvider {
	func useCase() -> StartupUseCase
}

public protocol SetupUseCaseProvider {
	func useCase() -> SetupUseCase
}

public protocol PopularMoviesUseCaseProvider {
	 func useCase() -> PopularMoviesUseCase
}

public protocol FavoriteMoviesUseCaseProvider {
	func useCase() -> FavoriteMoviesUseCase
}

public protocol CachedGenresUseCaseProvider {
	func useCase() -> CachedGenresUseCase
}
