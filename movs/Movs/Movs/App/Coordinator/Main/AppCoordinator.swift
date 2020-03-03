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
    
    var currentNavigationController: UINavigationController? {
        return self.navigationInCurrentViewController()
    }
    
    var lastViewController: UIViewController? {
        return self.lastViewControllerInCurrentViewController()
    }
    
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

//MARK: -Builder ViewController-
extension AppCoordinator {

    func make(scene: Scenes, type: ScenesType) {
        self.makeScene(scene)
        self.makeType(type)
    }
    
    
    private func makeScene(_ scene: Scenes) {
        var viewController: UIViewController!
        
        switch scene {
        case .tabBarView(_):
            guard let myTabBar = scene.buildScene() as? MyTabBarController else { return }
            self.tabBarViewController = myTabBar
            viewController = self.tabBarViewController
        default:
            viewController = scene.buildScene()
        }
        self.currentViewController = viewController
    }
    
    ///MakeType is required of method makeScene(_ scene:)
    private func makeType(_ type: ScenesType) {
        switch type {
        case .root:
            self.setupWindow()
        case .push:
            self.pushView()
        case .presentation(let modalPresentationStyle):
            self.presentationView(modalPresentationStyle)
        }
    }
}

//MARK: - Apresentation -
extension AppCoordinator {
    private func setupWindow() {
        self.window.rootViewController = self.currentViewController
        self.window.makeKeyAndVisible()
    }
    
    private func pushView() {
        if let navController = self.currentNavigationController {
            navController.pushViewController(self.currentViewController, animated: true)
        }
    }
    
    private func presentationView(_ modalPresentationStyle: UIModalPresentationStyle) {
        if let viewController = self.lastViewController {
            viewController.modalPresentationStyle = modalPresentationStyle
            viewController.present(self.currentViewController, animated: true)
        }
    }
}

//MARK: - Sup Functions -
extension AppCoordinator {
    private func navigationInCurrentViewController() -> UINavigationController? {
        if let myTabBar = self.currentViewController as? MyTabBarController {
            if let navController = myTabBar.viewControllerSelected as? UINavigationController {
                return navController
            }
        }
        return nil
    }
    
    private func lastViewControllerInCurrentViewController() -> UIViewController? {
        if let navController = self.currentNavigationController {
            return navController.topViewController
        }
        return nil
    }
}
