//
//  TabBarView.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class TabBarView: UITabBarController {

    // MARK: - Properties
    var presenter: TabBarPresenter!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Aply Design
        DesignManager.configureTabBar(tabBar: self.tabBar)
    }
}
