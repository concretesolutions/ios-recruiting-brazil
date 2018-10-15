//
//  AppDelegate.swift
//  Mov
//
//  Created by Allan on 03/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private func setupInterface(){
        UINavigationBar.appearance().barTintColor = Constants.Colors.yellow
        UINavigationBar.appearance().tintColor = UIColor.black
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Interface
        setupInterface()
        
        //Getting Favorites
        _ = FavoriteController.shared
        
        return true
    }


}

