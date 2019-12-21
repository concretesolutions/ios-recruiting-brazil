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
        child.view.layout.build {
            $0.top.equal(to: view.frameLayout.top)
            $0.bottom.equal(to: view.frameLayout.bottom)
            $0.left.equal(to: view.frameLayout.left)
            $0.right.equal(to: view.frameLayout.right)
        }
        child.didMove(toParent: self)
    }
}
