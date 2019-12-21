//
//  UIViewController+addChild.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChild(_ child: UIViewController, inView view: UIView, fillingAnchorable: Anchorable? = nil) {
        let layoutToFill: LayoutProxy = fillingAnchorable?.layout ?? view.frameLayout
        
        addChild(child)
        view.addSubview(child.view)
        child.view.layout.build {
            $0.top.equal(to: layoutToFill.top)
            $0.bottom.equal(to:layoutToFill.bottom)
            $0.left.equal(to: layoutToFill.left)
            $0.right.equal(to: layoutToFill.right)
        }
        child.didMove(toParent: self)
    }
}
