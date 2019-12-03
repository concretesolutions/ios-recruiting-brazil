//
//  ApperanceHelper.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 27/11/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import Foundation
import UIKit

struct ApperanceHelper {
    
    static func customizeTabBar() {
        let tabBarAppearace = UITabBar.appearance()
        tabBarAppearace.tintColor = CustomColor.black
        tabBarAppearace.unselectedItemTintColor = CustomColor.gray
        tabBarAppearace.barTintColor = CustomColor.yellow
    }
    
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = CustomColor.black
        navigationBarAppearace.barTintColor = CustomColor.yellow
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.black]
    }
}
