//
//  RootRouter.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 25/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

/**
 This class defines the root view controller to the app delegate window
*/
class RootRouter {
    
    func presentArticlesScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = TabBarController()
    }
    
}
