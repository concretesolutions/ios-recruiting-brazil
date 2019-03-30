//
//  Extensions.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit

fileprivate let lockviewTag = 9876543

extension UIView {
    
    //MARK: Lock and Unlock View
    func lock(duration: TimeInterval = 0.2) {
        guard self.viewWithTag(lockviewTag) == nil else { return }
        
        let lockView = UIView(frame: bounds)
        lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
        lockView.tag = lockviewTag
        lockView.alpha = 0.0
        let activity = UIActivityIndicatorView(style: .white)
        activity.hidesWhenStopped = true
        
        activity.center = lockView.center
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        lockView.addSubview(activity)
        activity.startAnimating()
        
        self.addSubview(child: lockView, whithAutoLayout: true)
        
        let xCenterConstraint = NSLayoutConstraint(item: activity, attribute: .centerX, relatedBy: .equal, toItem: lockView, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yCenterConstraint = NSLayoutConstraint(item: activity, attribute: .centerY, relatedBy: .equal, toItem: lockView, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([xCenterConstraint, yCenterConstraint])
        
        if duration == 0 {
            lockView.alpha = 1.0
        } else {
            UIView.animate(withDuration: duration) {
                lockView.alpha = 1.0
            }
        }
    }
    
    func unlock(duration: TimeInterval = 0.2) {
        guard let lockView = self.viewWithTag(lockviewTag) else { return }
        
        if duration == 0 {
            lockView.alpha = 0.0
        } else {
            UIView.animate(withDuration: duration, animations: {
                lockView.alpha = 0.0
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
    
    //MARK: - Add subview with autoLayout
    func addSubview(child: UIView, whithAutoLayout autoLayout: Bool) {
        self.addSubview(child)
        
        guard autoLayout else { return }
        
        child.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary = ["father":self, "child":child]
        
        let view_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[child(==father)]-0-|", options: .alignAllLeading, metrics: nil, views: viewsDictionary)
        let view_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[child(==father)]-0-|", options: .alignAllLeading, metrics: nil, views: viewsDictionary)
        
        NSLayoutConstraint.activate(view_constraint_V)
        NSLayoutConstraint.activate(view_constraint_H)
    }
}
