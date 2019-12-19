//
//  LayoutProxy.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// This is a proxy for the layout of a view. It has properties for each type of anchor of a view.
/// Use it to have access to this properties and use the constraint methods
class LayoutProxy: BuilderBlock {
    //A view or a layoutGuide
    var anchorable: Anchorable
    
    //each of this variables is a proxy for a Anchor of a Anchorable.
    //So, using them you can acess methods for making constraints.
    lazy var top = DefaultLayoutPropertyProxy(anchor: anchorable.topAnchor, layout: self, type: .top)
    lazy var bottom = DefaultLayoutPropertyProxy(anchor: anchorable.bottomAnchor, layout: self, type: .bottom)
    lazy var left = DefaultLayoutPropertyProxy(anchor: anchorable.leadingAnchor, layout: self, type: .left)
    lazy var right = DefaultLayoutPropertyProxy(anchor: anchorable.trailingAnchor, layout: self, type: .right)
    lazy var centerX = DefaultLayoutPropertyProxy(anchor: anchorable.centerXAnchor, layout: self, type: .centerX)
    lazy var centerY = DefaultLayoutPropertyProxy(anchor: anchorable.centerYAnchor, layout: self, type: .centerY)
    lazy var width = DefaultLayoutPropertyProxy(anchor: anchorable.widthAnchor, layout: self, type: .width)
    lazy var height = DefaultLayoutPropertyProxy(anchor: anchorable.heightAnchor, layout: self, type: .height)
        
    var group: LayoutPropertyGroup {
        return LayoutPropertyGroup(layout: self)
    }
    
    /// Initilized the Proxy
    /// - Parameter anchorable: a anchorable (a view or a layoutguide)
    init(anchorable: Anchorable) {
        self.anchorable = anchorable
    }
    
    /// It fills the given anchorable with the anchorable of the this layout
    /// - Parameters:
    ///   - view: the view to be filled
    ///   - margin: the margins to the above view borders
    func fill(view: Anchorable?, margin: CGFloat) {
        self.makeRelation(to: view, type: .top, operation: .margin(margin))
        self.makeRelation(to: view, type: .bottom, operation: .margin(-margin))
        self.makeRelation(to: view, type: .left, operation: .margin(margin))
        self.makeRelation(to: view, type: .right, operation: .margin(-margin))
    }
    
    /// It fills the superview with a margin
    /// - Parameter margin: the margin to the superview borders
    func fillSuperView(withMargin margin: CGFloat = 0) {
        self.fill(view: nil, margin: margin)
    }
    
    /// It makes the constraints between the given anchorable with the anchorable of this layout
    /// - Parameters:
    ///   - relatedAnchorable: the anchorable to make constraints with
    ///   - type: the type of the  Anchor to make the constraint
    ///   - operation: the operation of the constraint, it can be .multiply or .margin
    func makeRelation(to relatedAnchorable: Anchorable?, type: LayoutPropertyProxyType, operation: ConstraintOperation) {
        let anchorableSuperView = (self.anchorable as? UIView)?.superview
        
        guard let relatedAnchorable = relatedAnchorable ?? anchorableSuperView else {
            return
        }
        
        switch type {
        case .top:
            switch operation {
            case .multiply:
                fatalError()
            case .margin(let margin):
                self.top.equal(to: relatedAnchorable.layout.top, offsetBy: margin)
            }
        case .bottom:
            switch operation {
            case .multiply:
                fatalError()
            case .margin(let margin):
                self.bottom.equal(to: relatedAnchorable.layout.bottom, offsetBy: margin)
            }
        case .left:
            switch operation {
            case .multiply:
                fatalError()
            case .margin(let margin):
                self.left.equal(to: relatedAnchorable.layout.left, offsetBy: margin)
            }
        case .right:
            switch operation {
            case .multiply:
                fatalError()
            case .margin(let margin):
                self.right.equal(to: relatedAnchorable.layout.right, offsetBy: margin)
            }
        case .centerX:
            switch operation {
            case .multiply:
                fatalError()
            case .margin(let margin):
                self.centerX.equal(to: relatedAnchorable.layout.centerX, offsetBy: margin)
            }
        case .centerY:
            switch operation {
            case .multiply:
                fatalError()
            case .margin(let margin):
                self.centerY.equal(to: relatedAnchorable.layout.centerY, offsetBy: margin)
            }
        case .width:
            switch operation {
            case .multiply(let factor):
                self.width.equal(to: relatedAnchorable.layout.width, multiplier: factor)
            case .margin(let margin):
                self.width.equal(to: relatedAnchorable.layout.width, offsetBy: margin)
            }
        case .height:
            switch operation {
            case .multiply(let factor):
                self.height.equal(to: relatedAnchorable.layout.height, multiplier: factor)
            case .margin(let margin):
                self.height.equal(to: relatedAnchorable.layout.height, offsetBy: margin)
            }
        }
    }
}
