//
//  MovsNavigationController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovsNavigationController: UINavigationController {
    
    private var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.backgroundColor = Colors.mainYellow.color
        self.navigationBar.barTintColor = Colors.mainYellow.color
        self.navigationBar.tintColor = Colors.darkBlue.color
        self.navigationBar.largeTitleTextAttributes = [.foregroundColor:Colors.darkBlue.color]
    }
}
