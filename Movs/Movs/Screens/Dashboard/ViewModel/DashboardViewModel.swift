//
//  DashboardViewModel.swift
//  Movs
//
//  Created by Marcos Lacerda on 16/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

enum MovsTabs {
  case movies
  case favorites
  
  var title: String {
    switch self {
    case .movies: return "tab-movies".localized()
    case .favorites: return "tab-faved".localized()
    }
  }
  
  var icon: UIImage {
    switch self {
    case .movies: return #imageLiteral(resourceName: "tab-list-icon")
    case .favorites: return #imageLiteral(resourceName: "tab-faved-icon")
    }
  }
}

struct DashboardViewModel {
  
  fileprivate let controllers = [BaseNavigationViewController(rootViewController: MoviesViewController()), BaseNavigationViewController(rootViewController: FavoritesViewController())]

  var tabs: [MovsTabs] {
    return [.movies, .favorites]
  }
  
  var tabsControllers: [UIViewController] {
    return controllers
  }
  
  // MARK: - Life cycle
  
  init() {}
  
  // MARK: - Public methods
  
  func configureTabs() {
    for index in 0..<tabs.count {
      let tab = tabs[index]
      let controller = controllers[index]

      controller.tabBarItem = UITabBarItem(title: tab.title, image: tab.icon, tag: index)
      controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
    }
  }
  
}
