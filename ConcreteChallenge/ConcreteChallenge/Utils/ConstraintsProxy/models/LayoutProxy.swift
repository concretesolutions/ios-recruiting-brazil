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
        
    /// Initilized the Proxy
    /// - Parameter anchorable: a anchorable (a view or a layoutguide)
    init(anchorable: Anchorable) {
        self.anchorable = anchorable
    }
    
    func equalOnSuperView(type: LayoutPropertyProxyType) {
        guard let view = self.anchorable as? UIView,
              let superView = view.superview else {
            return
        }
        
        switch type {
        case .top:
            self.top.equal(to: superView.layout.top)
        case .bottom:
            self.bottom.equal(to: superView.layout.bottom)
        case .left:
            self.left.equal(to: superView.layout.left)
        case .right:
            self.right.equal(to: superView.layout.right)
        case .centerX:
            self.centerX.equal(to: superView.layout.centerX)
        case .centerY:
            self.centerY.equal(to: superView.layout.centerY)
        case .width:
            self.width.equal(to: superView.layout.width)
        case .height:
            self.height.equal(to: superView.layout.height)
        }
    }
}
