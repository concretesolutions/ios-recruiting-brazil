//
//  Coordinator.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 18/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

protocol Coordinator {
    associatedtype RootControllerType: UIViewController

    var rootViewController: RootControllerType { get }

    func start()
}
