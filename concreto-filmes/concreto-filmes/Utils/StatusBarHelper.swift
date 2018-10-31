//
//  StatusBarHelper.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 31/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
