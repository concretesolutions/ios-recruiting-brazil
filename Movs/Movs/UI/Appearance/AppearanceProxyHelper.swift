//
//  AppearanceProxyHelper.swift
//  Movs
//
//  Created by Brendoon Ryos on 24/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

struct AppearanceProxyHelper {
  
  private init() {}
  
  static let collectionViewSpacing: CGFloat = 15
  
  static func customizeTabBar(){
    let tabBarAppearance = UITabBar.appearance()
    tabBarAppearance.tintColor = ColorPalette.black
    tabBarAppearance.barTintColor = ColorPalette.white
  }
  
  static func customizeNavigationBar(){
    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.tintColor = ColorPalette.black
    navBarAppearance.barTintColor = ColorPalette.white
    navBarAppearance.prefersLargeTitles = true
  }  
}
