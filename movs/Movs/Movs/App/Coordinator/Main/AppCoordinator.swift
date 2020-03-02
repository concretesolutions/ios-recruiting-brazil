//
//  AppCoordinator.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

class AppCoordinator {
    fileprivate var window: UIWindow
    fileprivate var currentViewController: UIViewController!
    fileprivate var tabBarViewController: MyTabBarController!
    
    init(window: UIWindow?) {
        if let window = window {
            self.window = window
        
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
    }
    
    @available(iOS 13.0, *)
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window.windowScene = windowScene
    }
}

extension AppCoordinator {

    func make(scene: Scenes, type: ScenesType) {
        
        var viewController: UIViewController!
        
        switch scene {
        case .tabBarView(let scenes):
            self.tabBarViewController = scene.buildScene() as! MyTabBarController
            self.currentViewController = self.tabBarViewController
            self.createNavigationEach(scene: scenes)
        default:
            viewController = scene.buildScene()
            self.currentViewController = viewController
        }
        
        
        if type == .root {
            self.window.rootViewController = self.currentViewController
            self.window.makeKeyAndVisible()
        }
    }
    
    private func createNavigationEach(scene: [Scenes]) {
        
    }
}
