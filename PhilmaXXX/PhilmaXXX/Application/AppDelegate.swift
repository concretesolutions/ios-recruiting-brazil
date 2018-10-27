//
//  AppDelegate.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		let window = UIWindow(frame: UIScreen.main.bounds)
		
		Application.shared.configureMainInterface(in: window)
		
		self.window = window
		self.window?.makeKeyAndVisible()
		return true
	}

}

