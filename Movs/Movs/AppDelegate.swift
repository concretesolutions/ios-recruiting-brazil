//
//  AppDelegate.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        setup()
        window.rootViewController = buildRootViewController()
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

    func setup() {
        DependencyInjector.registerDependencies()
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black
        navigationBarAppearace.barTintColor = Design.Colors.clearYellow
    }

    func buildRootViewController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.barTintColor = Design.Colors.clearYellow

        let moviesCollection = MoviesViewController()
        moviesCollection.title = "movies.title".localized
        moviesCollection.tabBarItem = UITabBarItem(title: "movies.title".localized, image: UIImage(named: "list_icon"), tag: 0)

        let favoriteMovies = FavoriteMoviesViewController()
        favoriteMovies.title = "movies.title".localized
        favoriteMovies.tabBarItem = UITabBarItem(title: "common.favorites".localized, image: UIImage(named: "favorite_empty_icon"), tag: 1)

        let controllers = [moviesCollection, favoriteMovies]
        tabBarController.viewControllers = controllers.map({
            UINavigationController(rootViewController: $0)
        })
        return tabBarController
    }
}
