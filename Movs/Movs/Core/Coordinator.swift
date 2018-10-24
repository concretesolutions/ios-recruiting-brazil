//
//  Coordinator.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

typealias OnCoordinatorStarted = (UIViewController) -> Void

protocol Coordinator: AnyObject {
    var onCoordinatorStarted:OnCoordinatorStarted? { get set }
    func start()
}
