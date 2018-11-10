//
//  RootRouter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//


import UIKit

class RootRouter: RootWireframe {
    
    func presentScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = TabBarViewController()
    }
}
