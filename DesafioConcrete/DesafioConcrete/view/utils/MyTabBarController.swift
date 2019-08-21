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
        self.tabBar.tintColor = UIColor.customYellow
        self.tabBar.unselectedItemTintColor = UIColor.white
        
        let offset:CGFloat = 6
        
        if let items = tabBar.items {
            for item in items {
                item.title = ""
                item.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
            }
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let navigationController1 =  self.viewControllers![0] as? UINavigationController
        navigationController1!.popToRootViewController(animated: false)
        
        let navigationController2 =  self.viewControllers![1] as? UINavigationController
        navigationController2!.popToRootViewController(animated: false)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // delega para o view controller atual (o último do array) a decisao da orientacao suportada para o view controller que esta sendo exibido no momento
        return self.selectedViewController!.supportedInterfaceOrientations
    }
}

