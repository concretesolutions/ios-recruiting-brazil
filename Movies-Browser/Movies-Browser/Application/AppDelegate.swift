//
//  AppDelegate.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 17/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Variables -
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
}

// MARK: - UIApplicationDelegate Methods -
extension AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupGenresList()
        setupWindow()
        return true
    }
}

// MARK: - Window Setup -
extension AppDelegate {
    func setupWindow(){
        let navigationController = UINavigationController()
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        navigationController.navigationBar.tintColor = .systemPink
        setupCoordinator(navigationController: navigationController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

// MARK: - Coordinator Setup -
extension AppDelegate {
    func setupCoordinator(navigationController: UINavigationController){
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
    }
}

// MARK: - Genres List Persistence -
extension AppDelegate {
    func setupGenresList(){
        let database = Database()
        Service.request(router: Router.getMoviesGenres) { (genres: GenresList?, success: Bool) in
            if let genresList = genres, success {
                database.setGenresList(genresList: genresList.genres)
            }
        }
    }
}
