//
//  UISearchController+ViewWillppear.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension UISearchController {
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let presentingVC = self.presentingViewController {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.view.frame = presentingVC.view.frame
            }
        }
    }
}
