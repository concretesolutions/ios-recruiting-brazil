//
//  ListMovsCoordinator.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 21/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule
import ListMovsFeature

class ListMovsCoordinator: BaseCoordinator {
    private var navigationController = UINavigationController()
    private var listMovsRouter = ListMovsRouter()
    private var detailMovRouter: DetailItemMovsRouter?
}

//MARK: - Navigation -
extension ListMovsCoordinator {
    func showDetailItem(with itemViewData: MovsItemViewData) {
        self.detailMovRouter = DetailItemMovsRouter()
        if let ui = detailMovRouter?.makeUI(itemViewData: itemViewData) {
            navigationController.delegate = self
            navigationController.pushViewController(ui, animated: true)
        }
    }
}

//MARK: - Navigation Controller Delegete
extension ListMovsCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        
        if viewController is ListMovsViewController {
            self.detailMovRouter?.pop()
            self.detailMovRouter = nil
        }
    }
}

//MARK: - Default Coordinators -
extension ListMovsCoordinator: CoordinatorType {
    func currentViewController() -> UIViewController {
        return super.currentViewController
    }
    func start() {
        self.createCurrentView()
    }
    
    func pop() {
        
    }
}

//MARK: - Private funcs
extension ListMovsCoordinator {
    private func createCurrentView() {
        
        super.currentViewController = listMovsRouter.makeUI()
        super.currentViewController.tabBarItem = UITabBarItem(title: "Movies", image: Assets.TabBarItems.movies, tag: 0)
        navigationController.pushViewController(currentViewController, animated: true)
        
        super.currentViewController = self.navigationController
        
        listMovsRouter.detailView = { itemViewData in
            self.showDetailItem(with: itemViewData)
        }
    }
}

