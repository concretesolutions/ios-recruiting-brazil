//
//  MyTabBarController.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

class MyTabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = UIColor.black
        self.tabBar.tintColor = UIColor.yellow
        self.tabBar.unselectedItemTintColor = UIColor.white
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // delega para o view controller atual (o último do array) a decisao da orientacao suportada para o view controller que esta sendo exibido no momento
        return self.selectedViewController!.supportedInterfaceOrientations
    }
}

