//
//  ThemeInitializer.swift
//  RateX
//
//  Created by Andre on 12/07/2018.
//  Copyright © 2018 AndreSamples. All rights reserved.
//

import UIKit

class ThemeInitializer: Initializable {
    
    func performInitialization() {
        navigationBarAppearence()
        tabBarAppearence()
        statusBarAppearence()
        searchBarAppearence()
        sgmentedControlAppearence()
        tableViewAppearend()
    }
    
}

extension ThemeInitializer {
    
    private func statusBarAppearence() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func tabBarAppearence() {
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = .backgroundColorDarker
        UITabBar.appearance().isTranslucent = false
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(type: .regular, size: 14),
                                                          .foregroundColor: UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(type: .regular, size: 14),
                                                          .foregroundColor: UIColor.unselectedTextColor], for: .normal)
    }
    
    private func navigationBarAppearence() {
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barTintColor = .backgroundColorDarker
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = true
        let titleAttr: [NSAttributedString.Key : Any]  = [.foregroundColor: UIColor.white, .font: UIFont(type: .regular, size: 25)]
        UINavigationBar.appearance().titleTextAttributes = titleAttr
        UINavigationBar.appearance().largeTitleTextAttributes = titleAttr
        
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "ic_back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage  = #imageLiteral(resourceName: "ic_back")
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .disabled)
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .highlighted)
    }
    
    private func searchBarAppearence() {
        UISearchBar.appearance().tintColor = .white
        UISearchBar.appearance().barTintColor = .white
        
        let titleAttrNormal: [NSAttributedString.Key : Any] = [.font: UIFont(type: .regular, size: 14),
                                                              .foregroundColor: UIColor.white]
        let titleAttrDisabled: [NSAttributedString.Key : Any] = [.font: UIFont(type: .regular, size: 14),
                                                                  .foregroundColor: UIColor.unselectedTextColor]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(titleAttrNormal, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(titleAttrDisabled, for: .disabled)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = convertToNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.white, NSAttributedString.Key.font.rawValue: UIFont(type: .regular, size: 14)])
    }
    
    private func sgmentedControlAppearence() {
        let titleAttr: [NSAttributedString.Key : Any] = [.font: UIFont(type: .regular, size: 14)]
        UISegmentedControl.appearance().setTitleTextAttributes(titleAttr, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(titleAttr, for: .selected)
    }
    
    private func tableViewAppearend() {
        let colorView = UIView()
        colorView.alpha = 0.20
        colorView.backgroundColor = UIColor.white.withAlphaComponent(0.20)
        UITableViewCell.appearance().selectedBackgroundView = colorView
        UITableView.appearance().separatorColor = .unselectedTextColor
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
