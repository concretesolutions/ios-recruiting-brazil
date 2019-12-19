//
//  LayoutPropertyProxy+constraintMethods.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// Any LayoutPropertyProxy has methods for handling constraints
extension LayoutPropertyProxy {
    
    
    // so, here we are only using the default UIKit constrait methods to make the LayoutPropertyProxy methods.
    
    @discardableResult
    func equal(to otherAnchorLayout: DefaultLayoutPropertyProxy<AnchorType>, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = anchor.constraint(equalTo: otherAnchorLayout.anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func greaterThanOrEqual(to otherAnchorLayout: DefaultLayoutPropertyProxy<AnchorType>, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchorLayout.anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func lessThanOrEqual(to otherAnchorLayout: DefaultLayoutPropertyProxy<AnchorType>, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchorLayout.anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
}
