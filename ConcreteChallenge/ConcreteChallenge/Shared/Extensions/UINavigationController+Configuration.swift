//
//  UINavigationController+Configuration.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 18/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setupStyle() {
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = UIColor(named: "movs-yellow")
        navigationBar.barTintColor = UIColor(named: "movs-yellow")

        let defaultAttributes: [NSAttributedString.Key: Any]
        if #available(iOS 13.0, *) {
            defaultAttributes =  [ .foregroundColor: UIColor.label ]
        } else {
            defaultAttributes =  [ .foregroundColor: UIColor.black ]
        }

        navigationBar.titleTextAttributes = defaultAttributes
    }
}
