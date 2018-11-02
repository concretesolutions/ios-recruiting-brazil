//
//  AppDelegate.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 29/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UITabBar.appearance().tintColor = .orangePizazz
    UINavigationBar.appearance().tintColor = .orangePizazz
    return true
  }

}
