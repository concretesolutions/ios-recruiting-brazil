//
//  ApperanceProxyHelper.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 22/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import UIKit

struct ApperanceProxyHelper {
    
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.backgroundColor = UIColor.mainColor()
        navigationBarAppearace.barTintColor = UIColor.mainColor()
        navigationBarAppearace.tintColor = UIColor.mainDarkBlue()
        navigationBarAppearace.shadowImage = nil
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainDarkBlue(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        
    }
    
}
