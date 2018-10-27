//
//  ApplicationServices.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

struct ApplicationServices {
	let startupUseCaseProvider: Domain.StartupUseCaseProvider
	let setupUseCaseProvider: Domain.SetupUseCaseProvider
	let popularMoviesUseCaseProvider: Domain.PopularMoviesUseCaseProvider
	let favoriteMoviesUseCaseProvider: Domain.FavoriteMoviesUseCaseProvider
	let cachedGenresUseCaseProvider: Domain.CachedGenresUseCaseProvider
}
