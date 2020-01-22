//
//  NavigationController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .primary
        self.navigationBar.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard self.tabBarController == nil else { return }
        
        if let root = self.viewControllers.first {
            let backbutton = UIButton(type: .custom)
            backbutton.setTitle(Localizable.back, for: .normal)
            backbutton.setTitleColor(self.navigationBar.tintColor, for: .normal)
            backbutton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
            root.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        }
        
        self.reloadModalPresentation()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.reloadModalPresentation()
    }
    
    private func reloadModalPresentation() {
        self.viewControllers
            .enumerated()
            .forEach({ (index, view) in
                view.isModalInPresentation = (index != 0)
            })
    }
    
    @objc private func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
