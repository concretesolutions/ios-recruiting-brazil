//
//  AppCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class AppCoordinator: Coordinator {
    
    // MARK: - Typealiases
    
    typealias Presenter = UIWindow
    typealias Controller = HomeTabBarViewController
    
    // MARK: - Properties
    
    internal let dependencies: Dependencies
    internal let presenter: Presenter
    internal let coordinatedViewController: Controller
    
    // MARK: - Child coordinators
    
    private var favoriteMoviesCoordinator: FavoriteMoviesCoordinator!
    private var popularMoviesCoordinator: PopularMoviesCoordinator!
    
    // MARK: - Publishers and Subscribers
    
    private var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers
    
    init(window: UIWindow) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Failed to retrieve AppDelegate.")
        }
        
        self.dependencies = Dependencies(storageManager: StorageManager(container: appDelegate.persistentContainer))
        self.presenter = window
        self.coordinatedViewController = HomeTabBarViewController()
        self.popularMoviesCoordinator = PopularMoviesCoordinator(parent: self)
        self.favoriteMoviesCoordinator = FavoriteMoviesCoordinator(parent: self)
        
        self.bindDependencies()
    }
    
    deinit {
        for subscriber in self.subscribers {
            subscriber?.cancel()
        }
    }
    
    // MARK: - Coordination
    
    func start() {
        self.coordinatedViewController.viewControllers = [self.popularMoviesCoordinator.coordinatedViewController, self.favoriteMoviesCoordinator.coordinatedViewController]
        self.presenter.rootViewController = self.coordinatedViewController
        self.presenter.makeKeyAndVisible()
    }
    
    func finish() {
        self.presenter.rootViewController = nil
        self.presenter.resignKey()
    }
    
    // MARK: - Dependency Binding
    
    func bindDependencies() {
        self.subscribers.append(self.dependencies.apiManager.$genres
            .sink(receiveValue: { fetchedGenres in
                for fetchedGenre in fetchedGenres {
                    let genre = Genre(genreDTO: fetchedGenre)
                    self.dependencies.storageManager.storeGenre(genre: genre)
                }
                
                self.dependencies.storageManager.deleteGenresIfNeeded(fetchedGenres: fetchedGenres)
            })
        )
    }
}
