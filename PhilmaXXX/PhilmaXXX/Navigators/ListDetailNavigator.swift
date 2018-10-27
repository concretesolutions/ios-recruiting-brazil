//
//  ListDetailNavigator.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import UIKit

protocol ListDetailNavigator {
	func toPopularMoviesList()
}

final class DefaultListDetailNavigator: ListDetailNavigator {
	private let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func toPopularMoviesList() {
		navigationController.dismiss(animated: true)
	}
	
}
