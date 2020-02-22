//
//  SceneFactory.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

enum SceneFactory {
    
    static func createFeedScene(delegate: MovieViewPresenterDelegate?) -> MovieViewController {
        let movieViewController = MovieViewController()
        let moviePresenter = MoviePresenter(viewController: movieViewController, delegate: delegate)
        movieViewController.presenter = moviePresenter
        return movieViewController
    }
    
    static func createFavoritesScene() {
        
    }
}
