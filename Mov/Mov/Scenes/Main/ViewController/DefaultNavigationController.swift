//
//  DefaultNavigationController.swift
//  Mov
//
//  Created by Miguel Nery on 30/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class DefaultNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        layoutSetup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutSetup() {
        navigationBar.barTintColor = Colors.lightYellow
        navigationBar.tintColor = Colors.darkBlue
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
    
}
