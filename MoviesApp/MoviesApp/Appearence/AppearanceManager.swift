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
    
    static func customizeTextField(){
        let textFieldAppearance = UITextField.appearance()
        textFieldAppearance.attributedPlaceholder = NSAttributedString(string: "Search for Movies", attributes: [NSAttributedString.Key.foregroundColor : Palette.transparentBlue])
    }
    
    static func customizeSearchBar(){
        let searchBarAppearance = UISearchBar.appearance()
        searchBarAppearance.setImage(UIImage.icon.search, for: .search, state: .normal)
        searchBarAppearance.tintColor = Palette.blue
    }
    
    static var collectionViewSpacing:CGFloat{
        return 15.0
    }
    
}
