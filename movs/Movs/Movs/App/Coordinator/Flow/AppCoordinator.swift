//
//  AppCoordinator.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule

class AppCoordinator: BaseCoordinator {
    fileprivate var window: UIWindow
    fileprivate var tabBarViewController: MyTabBarController!
    fileprivate var childrensCoordinators = [String: CoordinatorType]()
    
    
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

//MARK: - Implement Default Coordinators
extension AppCoordinator: CoordinatorType {
    func currentViewController() -> UIViewController {
        super.currentViewController
    }
    
    func start() {
        addChildrenCoordinators()
        buildCurrentView()
        setupWindow()
    }
}

//MARK: - Setups  -
extension AppCoordinator {
    private func setupWindow() {
        self.window.rootViewController = self.currentViewController
        self.window.makeKeyAndVisible()
    }
    
    private func addChildrenCoordinators() {
        self.childrensCoordinators[Scenes.listMovsFeature.rawValue] = ListMovsCoordinator()
        self.childrensCoordinators[Scenes.favoriteFeature.rawValue] = FavoriteMovsCoordinator()
    }
    
    private func buildCurrentView() {
        guard let listCoordinator = self.childrensCoordinators[Scenes.listMovsFeature.rawValue],
            let favoriteCoordinator = self.childrensCoordinators[Scenes.favoriteFeature.rawValue] else {
            return
        }
        listCoordinator.start()
        favoriteCoordinator.start()
        let viewTab1 = listCoordinator.currentViewController()
        let viewTab2 = favoriteCoordinator.currentViewController()
        
        let viewControllers = [viewTab1, viewTab2]                
        let creator = MyTabBarCreator()
        let myTabBarViewController = creator.makeUI(with: viewControllers)                
        currentViewController = myTabBarViewController
    }
}

