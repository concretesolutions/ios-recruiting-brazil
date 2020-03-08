//
//  Scenes.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import ListMovsFeature
import AssertModule

enum Scenes {
    case tabBarView([Scenes])
    case listMovsFeature
    case favoriteFeature
}

extension Scenes {
    
    func buildScene(appCoordinator: AppCoordinator) -> UIViewController {
        switch self {
        case .tabBarView(let scenes):
            return self.tabBarView(scenes, appCoordinator: appCoordinator)
        case .listMovsFeature:
            let router = ListMovsRouter()
            let view = router.makeUI()
            router.showSearchView = { 
                appCoordinator.make(scene: .favoriteFeature, type: .presentation(.fullScreen))
            }
            return view
        case .favoriteFeature:
            let view = UIViewController()
            view.view.backgroundColor = .red
            return view
        }
    }
}

//MARK: - TabBarView Build -
extension Scenes {
    private func tabBarView(_ scenes: [Scenes], appCoordinator: AppCoordinator) -> MyTabBarController {
        let tabBarController = MyTabBarController()
        var listViews = [UIViewController]()
        scenes.forEach {
            let view = self.createScene($0, appCoordinator: appCoordinator)
            view.tabBarItem = self.createTabBarItem(by: $0, tag: listViews.count)
            listViews.append(view)
        }
        tabBarController.viewControllers = listViews
        return tabBarController
    }
    
    private func createTabBarItem(by scene: Scenes, tag: Int) -> UITabBarItem {
        
        switch scene {
        case .listMovsFeature:
            return UITabBarItem(title: "Movies",
                                image: Assets.TabBarItems.movies,
                                tag: tag)
        case .favoriteFeature:
            return UITabBarItem(title: "Favorites",
                                image: Assets.TabBarItems.favoriteEmpty,
                                tag: tag)
        case .tabBarView(_):
            return UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        }
    }
    private func createScene(_ scene: Scenes, appCoordinator: AppCoordinator) -> UIViewController {
        let viewController = scene.buildScene(appCoordinator: appCoordinator)
        return UINavigationController(rootViewController: viewController)
    }
}
