//
//  UIViewController+addChild.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChild(_ child: UIViewController, inView view: UIView) {
        addChild(child)
        view.addSubview(child.view)
        child.view.layout.fillSuperView()
        child.didMove(toParent: self)
    }
}
