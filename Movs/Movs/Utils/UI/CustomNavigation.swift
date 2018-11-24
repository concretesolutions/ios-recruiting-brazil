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
        viewController.definesPresentationContext = true
        self.navigationBar.prefersLargeTitles = false
        
        if title == "Favorites" {
            addFilterButtonOnRight(viewController: viewController)
        }
        
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
    
    // MARK: - Navigation Buttons
    
    func addFilterButtonOnRight(viewController: UIViewController){
        let barButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.filter))
        viewController.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func filter() {
        if let view = self.viewControllers.first as? FavoritesView {
            view.filter()
        }
    }
    
    // MARK: - Search Bar
    
    func setupSearchBar(viewController: UIViewController) {
        // UISearchController
        let searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.showsCancelButton = false
        searchController.obscuresBackgroundDuringPresentation = false
        // View Controller
        viewController.navigationItem.searchController = searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
        // Delegate
        viewController.navigationItem.searchController?.searchBar.delegate = self
    }
    
}

// MARK: - UISearchBarDelegate
extension CustomNavigation: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            if let view = self.viewControllers.first as? MoviesView {
                view.searchEnded()
            }
            if let view = self.viewControllers.first as? FavoritesView {
                view.searchEnded()
            }
        }else if let view = self.viewControllers.first as? MoviesView {
            view.search(text: searchText)
        }
        else if let view = self.viewControllers.first as? FavoritesView {
            view.search(text: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let view = self.viewControllers.first as? MoviesView {
            view.searchEnded()
        }
        if let view = self.viewControllers.first as? FavoritesView {
            view.searchEnded()
        }
    }
    
}


