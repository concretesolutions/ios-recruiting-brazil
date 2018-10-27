//
//  FavoritesFilterNavigator.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 24/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

protocol FavoritesFilterNavigator {
	func dismissToFavoritesList(filter: Filter?)
}

final class DefaultFavoritesFilterNavigator: FavoritesFilterNavigator {
	
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController){
		self.navigationController = navigationController
	}
	
	func dismissToFavoritesList(filter: Filter?) {
		let controllersCount = navigationController.viewControllers.count
		let viewController = navigationController.viewControllers[controllersCount-2] as! FavoritesListVC
		viewController.viewModel.filter = filter
		navigationController.popToViewController(viewController, animated: true)
	}
	
}
