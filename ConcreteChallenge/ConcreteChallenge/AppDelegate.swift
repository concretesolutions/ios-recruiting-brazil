//
//  AppDelegate.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    let viewModel = DefaultMoviesListViewModel(
        moviesRepository: DefaultMoviesRepository(moviesProvider: URLSessionJSONParserProvider<Page<Movie>>()),
        imagesRepository: DefaultMovieImageRepository(imagesProvider: URLSessionFileProvider())
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = PopularMoviesViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
        
        return true
    }
}

