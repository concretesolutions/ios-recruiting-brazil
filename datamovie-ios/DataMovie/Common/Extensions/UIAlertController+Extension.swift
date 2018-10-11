//
//  UIAlertController+Extension.swift
//  DataMovie
//
//  Created by Andre Souza on 09/10/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /// Set alert's content viewController
    ///
    /// - Parameters:
    ///   - vc: ViewController
    ///   - height: height of content viewController
    
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
}
