//
//  TabBarController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class TabBarControllerDelegate: NSObject, UITabBarControllerDelegate {
  
  var delegate: TabBarTapDelegate?
  
  var selectedTabIndex = 0
  
  init(delegate: TabBarTapDelegate) {
    self.delegate = delegate
  }

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let previousIndex = selectedTabIndex
    selectedTabIndex = tabBarController.selectedIndex
    
    if selectedTabIndex == 0 && previousIndex == 0 {
      delegate!.handleTapOnFirstIndex()
    }
  }
}

protocol TabBarTapDelegate: class {
  func handleTapOnFirstIndex()
}
