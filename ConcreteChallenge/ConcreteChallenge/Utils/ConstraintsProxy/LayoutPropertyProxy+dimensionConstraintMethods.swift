//
//  LayoutPropertyProxy+dimensionConstraintMethods.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// This extension is for layoutPropertyProxies where the AnchorType is a NSLayoutDimension. This means that the proxy is for a dimension anchor, like height and width, and this extension constaints the especific dimension methods.
extension LayoutPropertyProxy where AnchorType: NSLayoutDimension {
    @discardableResult
    func equal(to otherAnchorLayout: DefaultLayoutPropertyProxy<AnchorType>, multiplier: CGFloat) -> NSLayoutConstraint {
        /// Observe that the NSLayoutDimension is a type of NSLayoutAnchor where the AnchorType is also NSLayoutDimension,
        /// so to have acess to the dimensioning methods is necessary casting the anchor to NSLayoutDimension.
        
        guard let layoutDimension = self.anchor as? NSLayoutDimension,
              let otherAnchor = otherAnchorLayout.anchor as? NSLayoutDimension else {
            /// There is no NSLayoutDimension layout anchor that the AnchorType is not a NSLayoutDimension too.
            fatalError("NSLayoutDimension Layouts must have NSLayoutDimension as AnchorType")
        }
        
        let constraint = layoutDimension.constraint(equalTo: otherAnchor, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func equal(to constant: CGFloat) -> NSLayoutConstraint {
        guard let layoutDimension = self.anchor as? NSLayoutDimension else {
            fatalError("NSLayoutDimension Layouts must have NSLayoutDimension as AnchorType")
        }
    
        let constraint = layoutDimension.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
}
