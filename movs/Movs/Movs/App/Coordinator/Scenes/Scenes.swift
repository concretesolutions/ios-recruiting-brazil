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
    func buildScene() -> UIViewController {
        
        switch self {
        case .tabBarView(let scenes):
            return self.tabBarView(scenes)
        case .listMovsFeature:
            let router = ListMovsRouter()
            let view = router.makeUI()
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
    private func tabBarView(_ scenes: [Scenes]) -> MyTabBarController {
        let tabBarController = MyTabBarController()
        var listViews = [UIViewController]()
        scenes.forEach {
            let view = self.createScene($0)
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
    private func createScene(_ scene: Scenes) -> UIViewController {
        let viewController = scene.buildScene()
        return UINavigationController(rootViewController: viewController)
    }
}
