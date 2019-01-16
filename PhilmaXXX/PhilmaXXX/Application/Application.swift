//
//  Application.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform
import RealmPlatform

final class Application {
	static let shared = Application()
	private let services: ApplicationServices
	
	private init (){
		self.services = ApplicationServices(startupUseCaseProvider: NetworkPlatform.StartupUseCaseProvider(), environmentSetupUseCaseProvider:  RealmPlatform.EnvironmentSetupUseCaseProvider(), popularMoviesUseCaseProvider: NetworkPlatform.PopularMoviesUseCaseProvider(), favoriteMoviesUseCaseProvider: RealmPlatform.FavoriteMoviesUseCaseProvider(), filterUseCaseProvider:  RealmPlatform.FilterUseCaseProvider())
	}
	
	func configureMainInterface(in window: UIWindow){
		let pmNavigationController = popularMoviesNavigatorFactory()
		let fmNavigationController = favoriteMoviesNavigatorFactory()
		
		let tabBarControllers = [pmNavigationController, fmNavigationController]
		let tabBarViewController = tabBarViewFactory(viewControllers: tabBarControllers)
		
		window.rootViewController = tabBarViewController
	}
	
	private func tabBarViewFactory(viewControllers: [UIViewController]) -> UITabBarController {
		let viewModel = RootTabBarViewModel(startupUseCase: services.startupUseCaseProvider.useCase(), environmentSetupUseCase: services.environmentSetupUseCaseProvider.useCase())
		let tabBarController = RootTabBarController(viewModel: viewModel)
		tabBarController.viewControllers = viewControllers
		
		return tabBarController
	}
	
	private func popularMoviesNavigatorFactory() -> UIViewController {
		
		let navController = UINavigationController()
		let navigator = DefaultListNavigator(navigationController: navController, services: services)
		navController.tabBarItem = UITabBarItem(title: "Popular", image: #imageLiteral(resourceName: "list_icon"), selectedImage: nil)
		
		navigator.toPopularMoviesList()
		
		return navController
	}
	
	private func favoriteMoviesNavigatorFactory() -> UIViewController {
		let navController = UINavigationController()
		let navigator = DefaultFavoritesNavigator(navigationController: navController, services: services)
		navController.tabBarItem = UITabBarItem(title: "Favoritos", image: #imageLiteral(resourceName: "favorite_black_icon"), selectedImage: nil)
		
		navigator.toFavoritesList()
		
		return navController
	}
}
