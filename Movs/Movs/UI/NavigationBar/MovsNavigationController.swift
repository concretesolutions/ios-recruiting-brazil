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
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.commonInit()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.backgroundColor = Colors.mainYellow.color
        self.navigationBar.barTintColor = Colors.mainYellow.color
        self.navigationBar.tintColor = Colors.darkBlue.color
        self.navigationBar.largeTitleTextAttributes = [.foregroundColor:Colors.darkBlue.color, .font: Fonts.futuraBold.font(size: 34.0)]
    }
}
