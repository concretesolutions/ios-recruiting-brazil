//
//  UINavigationControllerExtension.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    internal func load<T>(_ type: StoryboardType) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: type.name, bundle: nil)

        guard let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Could not instantiate view controller with identifier: \(T.identifier)")
        }

        return controller
    }

    internal func push<T>(_ type: StoryboardType) -> T where T: UIViewController {
        let storyboard = UIStoryboard(name: type.name, bundle: nil)

        guard let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Could not instantiate view controller with identifier: \(T.identifier)")
        }

        self.pushViewController(controller, animated: true)

        return controller
    }
    
}
