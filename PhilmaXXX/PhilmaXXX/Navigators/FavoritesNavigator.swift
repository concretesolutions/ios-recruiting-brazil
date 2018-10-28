//
//  FavoritesNavigator.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 24/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

protocol FavoritesNavigator {
	func toFavoritesList()
	func toFavoritesFilter(filter: Filter)
	func toDetailMovie(_ movie: Movie, favorite: Bool)
}

final class DefaultFavoritesNavigator: FavoritesNavigator {
	private let navigationController: UINavigationController
	private let services: ApplicationServices
	
	init(navigationController: UINavigationController, services: ApplicationServices) {
		self.navigationController = navigationController
		self.services = services
	}
	
	func toFavoritesList() {
		let viewModel = FavoritesListVCModel(filterUseCase: services.filterUseCaseProvider.useCase(), favoriteMoviesUseCase: services.favoriteMoviesUseCaseProvider.useCase())
		let viewController = FavoritesListVC(navigator: self, viewModel: viewModel)
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func toFavoritesFilter(filter: Filter) {
		let navigator = DefaultFavoritesFilterNavigator(navigationController: navigationController)
		let viewModel = FavoritesFilterVCModel(filter: filter)
		let viewController = FavoritesFilterVC(navigator: navigator, viewModel: viewModel)
		
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func toDetailMovie(_ movie: Movie, favorite: Bool) {
		let navigator = DefaultListDetailNavigator(navigationController: navigationController)
		let viewModel = DetailMovieVCModel(filterUseCase: services.filterUseCaseProvider.useCase(), favoriteMoviesUseCase: services.favoriteMoviesUseCaseProvider.useCase(), movie: movie, favorite: favorite)
		let viewController = DetailMovieVC(viewModel: viewModel, navigator: navigator)
		navigationController.pushViewController(viewController, animated: true)
		
	}
	
}
