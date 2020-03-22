//
//  CoordinatorType.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 21/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

protocol CoordinatorType: AnyObject {
    func start()
    func pop()
    func currentViewController() -> UIViewController 
}
