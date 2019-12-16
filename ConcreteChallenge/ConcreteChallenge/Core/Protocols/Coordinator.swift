//
//  Coordinator.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 13/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator]? { get set }
    var rootViewController: UIViewController { get }

    func start()
}
