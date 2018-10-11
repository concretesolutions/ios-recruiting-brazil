//
//  UIViewController+Extension.swift
//  DataMovie
//
//  Created by Andre on 12/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static let navigationbarBackgroundColor = UIImage.from(color: .navigationColor)
    static let navigationbarBackgroundClear = UIImage.from(color: .clear)
    
    class func fromNib<T: UIViewController>() -> T {
        return self.init(nibName: self.identifier, bundle: nil) as! T
    }
    
    var topHeight: CGFloat {
        let barHeight = navigationController?.navigationBar.frame.height ?? 0
        let statusBarHeight = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
        return barHeight + statusBarHeight
    }
    
    func setNavbarTransparent() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIViewController.navigationbarBackgroundClear, for: .default)
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setDefaultNavbar(prefersLargeTitles: Bool = false) {
        navigationController?.navigationBar.setBackgroundImage(UIViewController.navigationbarBackgroundColor, for: .default)
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationController?.navigationBar.barTintColor = .navigationColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool, completion: (() -> Swift.Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }

    func showRightBarButtonIcon(target: Any? = self, action: Selector, imageIcon:UIImage) {
        let rightButton:UIBarButtonItem = UIBarButtonItem.init(image: imageIcon,
                                                               style: .plain,
                                                               target: target,
                                                               action: action)
        navigationItem.rightBarButtonItem = rightButton
    }
    
}
