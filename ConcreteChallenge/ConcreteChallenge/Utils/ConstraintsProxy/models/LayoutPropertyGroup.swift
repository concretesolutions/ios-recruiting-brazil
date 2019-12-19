//
//  LayoutPropertyGroup.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// A object responsible for saving the current state of a chain of constraint atribuitions. It is returned by the LayoutProxy.
class LayoutPropertyGroup {
    var layout: LayoutProxy
    var propertyTypes: [LayoutPropertyProxyType: ConstraintOperation] = [:]

    // the variables and methods bellow there are to enables the LayoutProxy user to continue increasing the chain of constraints.
    // the operations are ended when the user calls relatedToSuperView() or related(...), so all the constraints are applied
    var top: LayoutPropertyGroup { return self.top(0) }
    var bottom: LayoutPropertyGroup { return self.bottom(0) }
    var left: LayoutPropertyGroup { return self.left(0) }
    var right: LayoutPropertyGroup { return self.right(0) }
    var centerX: LayoutPropertyGroup { return self.centerX(0) }
    var centerY: LayoutPropertyGroup { return self.centerY(0) }
    var width: LayoutPropertyGroup { return self.width(.margin(0)) }
    var height: LayoutPropertyGroup { return self.height(.margin(0)) }
    
    init(layout: LayoutProxy) {
        self.layout = layout
    }
    
    func top(_ margin: CGFloat = 0) -> LayoutPropertyGroup {
        self.propertyTypes[.top] = .margin(margin)
        return self
    }
    
    func bottom(_ margin: CGFloat = 0) -> LayoutPropertyGroup {
        self.propertyTypes[.bottom] = .margin(margin)
        return self
    }
    
    func left(_ margin: CGFloat = 0) -> LayoutPropertyGroup {
        self.propertyTypes[.left] = .margin(margin)
        return self
    }
    
    func right(_ margin: CGFloat = 0) -> LayoutPropertyGroup {
        self.propertyTypes[.right] = .margin(margin)
        return self
    }
    
    func centerX(_ margin: CGFloat = 0) -> LayoutPropertyGroup {
        self.propertyTypes[.centerX] = .margin(margin)
        return self
    }
    
    func centerY(_ margin: CGFloat = 0) -> LayoutPropertyGroup {
        self.propertyTypes[.centerY] = .margin(margin)
        return self
    }
    
    func width(_ operation: ConstraintOperation) -> LayoutPropertyGroup {
        self.propertyTypes[.width] = operation
        return self
    }
    
    func height(_ operation: ConstraintOperation) -> LayoutPropertyGroup {
        self.propertyTypes[.height] = operation
        return self
    }
    
    /// It apply all the constraints of the group related with the superview.
    func relatedToSuperView() {
        self.related(to: nil)
    }
    
    /// It apply all the constraints of the group related with the given anchorable.
    func related(to anchorable: Anchorable? = nil) {
        self.propertyTypes.keys.forEach { (constraintPropertyType) in
            guard let operation = self.propertyTypes[constraintPropertyType] else {
                return
            }
            layout.makeRelation(to: anchorable, type: constraintPropertyType, operation: operation)
        }
    }
}
