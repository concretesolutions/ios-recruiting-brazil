//
//  RootRouter.swift
//  Movies
//
//  Created by Renan Germano on 24/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    
    func presentScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = MovsTabbarViewController()
    }
}
