//
//  UIView+Utils.swift
//  Wonder
//
//  Created by Marcelo on 07/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

extension UIView {
    
    
    // MARK: - Error Handler
    func showErrorView(errorHandlerView: UIView) {
        errorHandlerView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        errorHandlerView.tag = 1001
        self.addSubview(errorHandlerView)
    }
    
    func hideErrorView(view: UIView) {
        self.viewWithTag(1001)?.removeFromSuperview()
    }

    
    // MARK: - Hud Activity
    
    func showActivityLoading() {
        let shadowView = UIView(frame:CGRect(x: 0, y:0, width:self.frame.size.width, height:self.bounds.size.height))
        shadowView.tag = -998;
        shadowView.backgroundColor = UIColor(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 0.5)
        self.alpha = 0.5
        
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activity.center = self.center
        activity.tag = -999
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(shadowView)
        
        self.addSubview(shadowView)
        self.addSubview(activity)
        activity.startAnimating()
    }
    
    func hideActivityLoading() {
        self.alpha = 1.0
        self.viewWithTag(-998)?.removeFromSuperview()
        self.viewWithTag(-999)?.removeFromSuperview()
    }
    
}

