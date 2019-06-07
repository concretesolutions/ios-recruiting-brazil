//
//  TabBarViewController.swift
//  Cineasta
//
//  Created by Tomaz Correa on 01/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - VARIABLES -
    private var presenter: TabBarPresenter!
    private lazy var viewData = TabBarViewData()
}

// MARK: - LIFE CYCLE -
extension TabBarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TabBarPresenter(viewDelegate: self)
        self.presenter.getTabBarItems()
        self.delegate = self
        self.removeTabBarShadow()
    }
}

// MARK: - PRESENTER -
extension TabBarViewController: TabBarViewDelegate {
    func setTabBarItems(_ viewData: TabBarViewData) {
        self.viewData = viewData
        var viewControllers = [UIViewController]()
        for tabBarItem in self.viewData.tabBarItems {
            let storyboard = UIStoryboard(name: tabBarItem.storyboardName, bundle: nil)
            if let viewController = storyboard.instantiateInitialViewController() {
                viewControllers.append(viewController)
            }
        }
        self.setViewControllers(viewControllers, animated: false)
    }
}

// MARK: - TABBAR CONTROLLER DELEGATE -
extension TabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabBarButton = self.tabBar.subviews.filter({
            guard let swappableImageView = $0.subviews.first as? UIImageView,
                swappableImageView.image == item.selectedImage else { return false }
            return true
        }).first else { return }
        self.pulseAnimation(tabBarButton)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view,
            let toView = viewController.view else { return false }
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }
}

// MARK: - AUX METHODS -
extension TabBarViewController {
    private func removeTabBarShadow() {
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
    }
    
    private func pulseAnimation(_ tabBarButton: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            tabBarButton.transform = .init(scaleX: 1.4, y: 1.4)
        }, completion: { _ in
            tabBarButton.transform = .identity
        })
    }
}
