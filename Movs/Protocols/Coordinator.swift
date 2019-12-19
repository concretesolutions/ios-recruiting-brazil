//
//  Coordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    // MARK: - Associated types
    
    associatedtype Presenter
    associatedtype Controller: UIViewController

    // MARK: - Properties
    
    var dependencies: Dependencies { get }
    var presenter: Presenter { get }
    var coordinatedViewController: Controller { get }
        
    // MARK: - Coordination
    
    func start()
    func finish()
}
