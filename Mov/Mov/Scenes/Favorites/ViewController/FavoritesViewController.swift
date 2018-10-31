//
//  FavortiesViewController.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private static let title = "Favorites"
    
    lazy var favoritesView: FavoritesView = {
        return FavoritesView(frame: .zero)
    }()
    
    override func loadView() {
        self.view = BlankView()
        self.setup()
    }
    
    override func viewDidLoad() {
        self.setTabBarOptions()
        self.title = FavoritesViewController.title
    }
}

extension FavoritesViewController: ViewCode {
    func addView() {
        self.view.addSubview(self.favoritesView)
    }
    
    func addConstraints() {
        self.favoritesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: TabBar setup
extension FavoritesViewController {
    func setTabBarOptions() {
        self.tabBarItem = UITabBarItem(title: FavoritesViewController.title,
                                       image: Images.favoritesIcon, tag: 1)
    }
}

