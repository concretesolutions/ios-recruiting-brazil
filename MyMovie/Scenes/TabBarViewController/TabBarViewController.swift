//
//  ViewController.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 20/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
	
	var movieViewController: MovieViewController!
	var favoriteViewController: FavoriteViewController!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.defineStoryboards()
		self.definePropertyTabIcon()
		
		setupNavControllers()

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
				
	
	}
	
	/**
	@object: Setar a storyboard no tabBar.
	@param:
	@return:
	*/
	func defineStoryboards() {
		self.movieViewController = UIStoryboard(name: "MovieStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieViewController") as? MovieViewController
	
		self.favoriteViewController = UIStoryboard(name: "FavoriteStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController
	}
	
	/**
	@object: Define as propriedades da tabBar.
	@param:
	@return:
	*/
	func definePropertyTabIcon() {
		self.movieViewController.tabBarItem.title = "Movies"
		self.favoriteViewController.tabBarItem.title  = "Favorites"
		
		self.movieViewController.tabBarItem.image = UIImage(named: "listIcon")
		self.favoriteViewController.tabBarItem.image = UIImage(named: "favoriteEmptyIcon")
		
	}

	
	func setupNavControllers(){
		let navigationControllerMovie = UINavigationController(rootViewController: movieViewController)
		let navigationControllerFavorite = UINavigationController(rootViewController: favoriteViewController)
		self.viewControllers = [navigationControllerMovie, navigationControllerFavorite]
	}

}
