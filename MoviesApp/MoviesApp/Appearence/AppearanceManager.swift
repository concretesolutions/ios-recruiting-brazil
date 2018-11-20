//
//  AppearanceManager.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

struct AppearanceManager{
    
    static func customizeNavigationBar(){
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = Palette.blue
        navigationBarAppearance.barTintColor = Palette.yellow
        navigationBarAppearance.prefersLargeTitles = true
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:Palette.blue]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:Palette.blue]
    }
    
    static func customizeTabBar(){
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.unselectedItemTintColor = Palette.blue
        tabBarAppearance.tintColor = Palette.blue
        tabBarAppearance.barTintColor = Palette.yellow
    }
    
    static var collectionViewSpacing:CGFloat{
        return 15.0
    }
    
    static var navigationHeight:CGFloat{
        return UINavigationBar.appearance().frame.height
    }
    
}
