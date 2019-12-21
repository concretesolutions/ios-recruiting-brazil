//
//  Coordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// This must be implemented by any type that acts as a coordinator.
@objc protocol CoordinatorProtocol {
    var rootViewController: RootViewController { get set }
    
    /// This method must be called to do the initial setup of the navigation flow starting from the current coordinator.
    ///
    /// - Parameter previousController: the viewcontroller that was presented before the current coordinator be started.
    func start(previousController: UIViewController?)
}
