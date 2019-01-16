//
//  ListNavigator.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

protocol ListNavigator {
	func toPopularMoviesList()
	func toDetailMovie(_ movie: Movie, favorite: Bool)
}

class DefaultListNavigator: ListNavigator {
	private let navigationController: UINavigationController
	private let services: ApplicationServices
	
	init(navigationController: UINavigationController, services: ApplicationServices) {
		self.navigationController = navigationController
		self.services = services
	}
	
	func toPopularMoviesList() {
		let pmViewModel = PopularMoviesVCModel(popularMoviesUseCase: services.popularMoviesUseCaseProvider.useCase(), favoriteMoviesUseCase: services.favoriteMoviesUseCaseProvider.useCase())
		let pmViewController = PopularMoviesVC(viewModel: pmViewModel, navigator: self)
		navigationController.pushViewController(pmViewController, animated: true)
	}
	
	func toDetailMovie(_ movie: Movie, favorite: Bool) {
		let navigator = DefaultListDetailNavigator(navigationController: navigationController)
		let viewModel = DetailMovieVCModel(filterUseCase: services.filterUseCaseProvider.useCase(), favoriteMoviesUseCase: services.favoriteMoviesUseCaseProvider.useCase(), movie: movie, favorite: favorite)
		let viewController = DetailMovieVC(viewModel: viewModel, navigator: navigator)
		navigationController.pushViewController(viewController, animated: true)
		
	}
}
