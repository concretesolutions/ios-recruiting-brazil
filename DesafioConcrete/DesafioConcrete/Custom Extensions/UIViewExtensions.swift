//
//  UIViewExtensions.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func setUpContraint(pattern: String, views: UIView...) {
        var myViews: [String : UIView] = [:]
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            myViews["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: pattern, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: myViews))
    }
    
}
