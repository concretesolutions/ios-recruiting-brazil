//
//  UIView+Extensions.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: View animations
    /**
     Animate changes made to the constraints on the current view's superview.
     
     - Parameter duration: Duration of the animation, in seconds.
     - Parameter completion: A block of code to be executed once the animation finishes.
     */
    func animateConstraints(duration: TimeInterval = 0.0, _ completion: (() -> Void)? = nil) {

        // Transform the completion type to conform with the UIView.animate completion
        let newCompletion: ((Bool) -> Void)? = { _ in
            completion?()
        }

        // Animate changes on superview, if it exists
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            if let superview = self.superview {
                superview.layoutIfNeeded()
            } else {
                self.layoutIfNeeded()
            }
        }, completion: newCompletion)
    }
}


