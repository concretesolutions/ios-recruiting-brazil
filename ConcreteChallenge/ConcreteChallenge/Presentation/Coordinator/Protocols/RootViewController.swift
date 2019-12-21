//
//  RootViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// This protocol represent a viewcontroller that can have subcontrollers and acts as a ContainerViewController,
/// as UINavigaitonController or UITabBarController,
/// and abstracts the subcontrollers addition to use in generic contexts.
@objc protocol RootViewController where Self: UIViewController {
    
    // Adds a view controller to a rootViewController.
    func add(viewController: UIViewController)
}
