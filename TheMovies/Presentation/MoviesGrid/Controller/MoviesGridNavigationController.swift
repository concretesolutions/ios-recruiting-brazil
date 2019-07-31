//
//  MovieNavigationController.swift
//  ViperitTest
//
//  Created by Matheus Bispo on 7/25/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit

final class MoviesGridNavigationController: UINavigationController {
    //MARK:- Variables -
    
    //MARK:- Constructors -
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupNavigationBar()
        setupTabBarItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Override Methods -

    //MARK:- Methods -
    fileprivate func setupNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationBar.barTintColor = .white
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        self.navigationBar.shadowImage = UIImage()
        
        self.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 21)!]
        
        let originalFrame = self.navigationBar.bounds
        self.navigationBar.frame = CGRect(x: 0, y: 0, width: originalFrame.width, height: originalFrame.height - 10)
        self.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupTabBarItem() {
        let tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie_icon"), tag: 0)
        
        self.tabBarItem = tabBarItem
    }
    
}
