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
    
    private func tabBarView(_ scenes: [Scenes]) -> MyTabBarController {
        let tabBarController = MyTabBarController()
        var listViews = [UIViewController]()
        scenes.forEach {
            let view = $0.buildScene()
            view.tabBarItem = self.createTabBarItem(by: $0, tag: listViews.count)
            listViews.append(view)
        }
        tabBarController.viewControllers = listViews        
        return tabBarController
    }
    
    private func createTabBarItem(by scene: Scenes, tag: Int) -> UITabBarItem {
        
        switch scene {
        case .listMovsFeature:
            let image = UIImage(named: "list_icon")
            return UITabBarItem(title: "Movies", image: image, tag: tag)
        case .favoriteFeature:
            return UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_gray_icon"), tag: tag)
        case .tabBarView(_):
            return UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        }
    }
}
