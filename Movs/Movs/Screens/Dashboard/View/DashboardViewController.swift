//
//  DashboardViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 16/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class DashboardViewController: UITabBarController {
  
  // MARK: - Private properties
  
  fileprivate let viewModel: DashboardViewModel = DashboardViewModel()

  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.customizeTabBar()
  }
  
  // MARK: - Private methods
  
  fileprivate func customizeTabBar() {
    self.tabBar.barTintColor = #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1)
    self.viewControllers = viewModel.tabsControllers
    self.viewModel.configureTabs()

    let appearance = UITabBarItem.appearance()
    let unselectedColor = UIColor.black
    let selectedColor = #colorLiteral(red: 0.5725490196, green: 0.4941176471, blue: 0.3176470588, alpha: 1)

    appearance.setTitleTextAttributes([.foregroundColor: unselectedColor], for: .normal)
    appearance.setTitleTextAttributes([.foregroundColor: selectedColor], for: .selected)
  }
  
}
