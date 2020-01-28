//
//  UIView+extension.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 24/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

extension UIView {
    
    func activityStartAnimating() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = self.center
        activityView.color = .gray
        
        backgroundView.addSubview(activityView)
        self.addSubview(backgroundView)
        activityView.startAnimating()
    }

    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
