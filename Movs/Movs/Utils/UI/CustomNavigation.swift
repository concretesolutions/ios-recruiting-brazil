//
//  CustomNavigation.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class CustomNavigation: UINavigationController {
    
    init(viewController: UIViewController, title: String) {
        super.init(rootViewController: viewController)
        
        // Setup Navigation
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        UINavigationBar.appearance().barTintColor = ColorPallete.yellow
        UINavigationBar.appearance().tintColor = UIColor.gray
        UINavigationBar.appearance().barStyle = .default
        viewController.navigationItem.title = title
        viewController.tabBarItem.title = title
        self.navigationBar.prefersLargeTitles = false
        
        // Search Bar
        setupSearchBar(viewController: viewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    func setupSearchBar(viewController: UIViewController) {
        let searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchBar.searchBarStyle = .minimal
        viewController.navigationItem.searchController = searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}



