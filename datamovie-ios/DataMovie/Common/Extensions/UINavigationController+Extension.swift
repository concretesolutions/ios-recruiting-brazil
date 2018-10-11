//
//  UINavigationController+Extension.swift
//  RateX
//
//  Created by Andre on 10/07/2018.
//  Copyright © 2018 AndreSamples. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
    
}
