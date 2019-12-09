//
//  NavigationController.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

/// Custom UINavigationController to use on this app
class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.navigationBar.barTintColor = Colors.almostBlack
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = Colors.tmdbGreen
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationBar.titleTextAttributes = textAttributes
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
