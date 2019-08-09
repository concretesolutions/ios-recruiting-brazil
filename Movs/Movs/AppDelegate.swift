//
//  AppDelegate.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initWindow()
    initRootViewController()

    window?.makeKeyAndVisible()

    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {}
  
  func applicationDidEnterBackground(_ application: UIApplication) {}
  
  func applicationWillEnterForeground(_ application: UIApplication) {}
  
  func applicationDidBecomeActive(_ application: UIApplication) {}
  
  func applicationWillTerminate(_ application: UIApplication) {}
  
  // MARK: - Private methods
  
  fileprivate func initRootViewController() {
    let splashController = SplashViewController()
    self.changeRootViewController(splashController)
  }
  
  // MARK: - Init methods
  
  fileprivate func initWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
  }
  
  // MARK: - Commom methods
  
  func changeRootViewController(_ rootViewController: UIViewController) {
    guard let window = self.window else { return }
    window.rootViewController = rootViewController
    
    UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
    }, completion: nil)
  }
  
}
