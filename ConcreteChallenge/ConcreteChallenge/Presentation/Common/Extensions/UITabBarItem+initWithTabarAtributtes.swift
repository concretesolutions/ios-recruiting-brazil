//
//  UITabBarItem+initWithTabarAtributtes.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

enum TabbarAttributtes {
    case system(UITabBarItem.SystemItem)
    case custom(String, String)
}

extension UITabBarItem {
    convenience init(tabbarAttributtes: TabbarAttributtes) {
        switch tabbarAttributtes {
        case .custom(let title, let imageName):
            self.init(
                title: title,
                image: UIImage(named: imageName),
                tag: 0
            )
        case .system(let systemItem):
            self.init(tabBarSystemItem: systemItem, tag: 0)
        }
    }
}
