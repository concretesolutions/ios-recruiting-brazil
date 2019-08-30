//
//  WindowHelper.swift
//  TestUITests
//
//  Created by Nadilson Santana on 08/08/19.
//  Copyright © 2019 DigitalHouse. All rights reserved.
//

import UIKit

class WindowHelper {
    
    static var testWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        return window
    }()
    
    static func showInTestWindow(viewController: UIViewController) {
        WindowHelper.testWindow.rootViewController = viewController
        WindowHelper.testWindow.makeKeyAndVisible()
    }
    
    static func cleanTestWindow() {
        WindowHelper.testWindow.rootViewController = nil
        WindowHelper.testWindow.isHidden = true
    }
}
