//
//  Coordinator.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

protocol Coordinator {
    var rootViewController: UIViewController { get }
    func start()
}
