//
//  AppDelegate.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 23/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        resetStateIfUITesting()

        self.setupWindow()
        return true
    }

    private func resetStateIfUITesting() {
        if ProcessInfo.processInfo.arguments.contains("UI-Testing") {
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            let realm = RealmService.shared.realm
            do {
                try realm?.write {
                    realm?.deleteAll()
                }
            } catch {
                print(error)
            }
        }
    }
}

extension AppDelegate {

    /// Makes the initial setups of the application window
    private func setupWindow() {
        window = UIWindow()
        window?.makeKeyAndVisible()
        UIApplication.shared.statusBarView?.backgroundColor = AppColors.mainYellow.color
        window?.rootViewController = TabController()
    }
}
