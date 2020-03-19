//
//  UIViewController+Extensions.swift
//  CommonsModule
//
//  Created by Marcos Felipe Souza on 02/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

public extension UIViewController {
    var topAnchorSafeArea: NSLayoutYAxisAnchor {
        let topAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *) {
            topAnchor = view.safeAreaLayoutGuide.topAnchor
        } else {
            topAnchor = topLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var bottomAnchorSafeArea: NSLayoutYAxisAnchor {
        let topAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *) {
            topAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            topAnchor = topLayoutGuide.bottomAnchor
        }
        return topAnchor
    }
    
}
