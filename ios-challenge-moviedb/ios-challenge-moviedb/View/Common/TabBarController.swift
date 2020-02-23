//
//  TabBarController.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .blue
        self.tabBar.barTintColor = .white
//        MovieClient.getPopularMovies(page: 1) { (movies, error) in
////            print("Movies:\n", movies)
//        }
//        MovieClient.getAllGenres { (genres, error) in
//            print("Genres:\n", genres)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
