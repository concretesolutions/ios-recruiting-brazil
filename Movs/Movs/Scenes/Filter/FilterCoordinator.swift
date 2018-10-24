//
//  FilterCoordinator.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FilterCoordinator: Coordinator {
    
    var onCoordinatorStarted: OnCoordinatorStarted?
    
    func start() {
        let vc = FilterViewController()
        vc.presenter = FilterPresenter(view: vc, coordinator: self)
    }
}
