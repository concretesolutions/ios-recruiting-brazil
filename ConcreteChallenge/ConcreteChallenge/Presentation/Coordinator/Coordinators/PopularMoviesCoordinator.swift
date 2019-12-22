//
//  PopularMoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

enum TabbarAttributtes {
    case system(UITabBarItem.SystemItem)
    case custom(String, String)
}
typealias PopularCoordinatorAtributtes = (navigationTitle: String, tabbarAttributtes: TabbarAttributtes)

extension UITabBarItem {
    convenience init(tabbarAttributtes: TabbarAttributtes) {
        switch tabbarAttributtes {
        case .custom(let title, let imageName):
            self.init(
                title: title,
                image: UIImage(named: imageName),
                tag: 0
            )
        case .system(let systemItem):
            self.init(tabBarSystemItem: systemItem, tag: 0)
        }
    }
}

class PopularMoviesCoordinator: Coordinator {
    var rootViewController: RootViewController
    
    private lazy var popularMoviesViewController: PopularMoviesViewController = {
        let viewModel = self.viewModelsFactory.movieListViewModel()
        viewModel.navigator = self
        
        let popularMoviesViewController = PopularMoviesViewController(viewModel: viewModel)
        return popularMoviesViewController
    }()
    private var movieDetailCoordinator: MovieDetailCoordinator?
    private var viewModelsFactory: ViewModelsFactory
    private let atributtes: PopularCoordinatorAtributtes
    
    init(rootViewController: RootViewController, viewModelsFactory: ViewModelsFactory, atributtes: PopularCoordinatorAtributtes) {
        self.rootViewController = rootViewController
        self.viewModelsFactory = viewModelsFactory
        self.atributtes = atributtes
    }
    
    func start(previousController: UIViewController? = nil) {
        rootViewController.add(viewController: popularMoviesViewController)
        
        popularMoviesViewController.title = atributtes.navigationTitle
        
        rootViewController.tabBarItem = UITabBarItem(tabbarAttributtes: atributtes.tabbarAttributtes)
        rootViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
    }
}

extension PopularMoviesCoordinator: MoviesListViewModelNavigator {
    func movieWasSelected(movie: Movie) {
        movieDetailCoordinator = MovieDetailCoordinator(
            rootViewController: rootViewController,
            movie: movie,
            viewModelsFactory: self.viewModelsFactory
        )
        movieDetailCoordinator?.start(previousController: popularMoviesViewController)
    }
}
