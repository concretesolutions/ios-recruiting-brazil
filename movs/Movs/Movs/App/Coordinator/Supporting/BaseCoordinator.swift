//
//  BaseCoordinator.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 21/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

class BaseCoordinator: NSObject {
    var currentViewController: UIViewController!
    
    var currentNavigationController: UINavigationController? {
        
        if self.currentViewController == nil {
            return nil
        }
        return self.currentViewController.navigationController
    }
    
    var lastViewController: UIViewController? {
        return self.lastViewControllerInCurrentViewController()
    }
    
    
    private func lastViewControllerInCurrentViewController() -> UIViewController? {
        if let navController = self.currentNavigationController {
            return navController.topViewController
        }
        return nil
    }
    
    
    func pushView(viewController: UIViewController) {
        if let navController = self.currentNavigationController {
            navController.pushViewController(viewController, animated: true)
        }
    }
    
    func presentationView(viewController: UIViewController,
                          modalPresentationStyle: UIModalPresentationStyle) {
        
        if let viewController = self.lastViewController {
            viewController.modalPresentationStyle = modalPresentationStyle
            viewController.present(viewController, animated: true)
        }
    }
}
