//
//  TabBarViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: OUTLETS
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: TabBarPresenter!
    private lazy var viewData:TabBarViewData = TabBarViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension TabBarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.presenter = TabBarPresenter(viewDelegate: self)
        self.presenter.getTabBarItens()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

//MARK: - DELEGATE PRESENTER -
extension TabBarViewController: TabBarViewDelegate {
    func setViewData(tabbarNewViewData: TabBarViewData) {
        self.viewData = tabbarNewViewData
        self.createTabBar()
    }
}

// MARK: - UITABBARCONTROLLERDELEGATE -
extension TabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let navigation = self.selectedViewController as? UINavigationController, navigation.viewControllers.count > 1 {
            navigation.popToRootViewController(animated: false)
        }
            HapticAlert.hapticReturn(style: .medium)
            if let subView = self.tabBar.subviews.filter({($0.subviews.first as? UIImageView)?.image == item.selectedImage}).first?.subviews.first {
                UIView.animate(withDuration: 0.1, animations: {
                    subView.transform = .init(scaleX: 1.5, y: 1.5)
                }) { (_) in
                    subView.transform = .identity
                }
            }
        }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarAnimatedTransitioning()
    }
}

//MARK: - AUX METHODS -
extension TabBarViewController {
    private func createTabBar() {
        var controllers = [UIViewController]()
        for viewDataRow in self.viewData.tabaBarItens {
            let controller = self.getViewController(viewData: viewDataRow)
            controller.tabBarItem = self.getTabBarItem(viewData: viewDataRow)
            controllers.append(controller)
        }
        self.viewControllers = controllers
        self.selectedIndex = 0
    }
    
    private func getViewController(viewData: TabBarItem) -> UIViewController {
        let storyboard = UIStoryboard(name: viewData.storyBoard.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewData.viewControllerIdentifier.rawValue)
        return viewController
    }
    
    private func getTabBarItem(viewData: TabBarItem) -> UITabBarItem {
        let item = UITabBarItem(title: viewData.name.rawValue, image: viewData.imageTabBar.imageNotSelected?.withRenderingMode(.alwaysOriginal), selectedImage: viewData.imageTabBar.imageSelected?.withRenderingMode(.alwaysOriginal))
        let attibutes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)]
        item.setTitleTextAttributes(attibutes, for: .normal)
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 2)
        return item
    }
    
    private func setupTabBar() {
//        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.tabBar.layer.shadowRadius = 7
//        self.tabBar.layer.shadowColor = UIColor.tDarkGrey().cgColor
//        self.tabBar.layer.shadowOpacity = 0.7
    }
}
