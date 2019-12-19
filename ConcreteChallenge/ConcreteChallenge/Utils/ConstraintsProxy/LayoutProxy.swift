//
//  LayoutProxy.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// This is a proxy for the layout of a view. It has properties for each type of anchor of a view.
/// Use it to have access to this properties and use the constraint methods
class ViewLayoutProxy: BuilderBlock {
    //A view or a layoutGuide
    var anchorable: Anchorable
    
    //each of this variables is a proxy for a Anchor of a Anchorable.
    //So, using them you can acess methods for making constraints.
    lazy var top = DefaultLayoutPropertyProxy(anchor: anchorable.topAnchor)
    lazy var bottom = DefaultLayoutPropertyProxy(anchor: anchorable.bottomAnchor)
    lazy var left = DefaultLayoutPropertyProxy(anchor: anchorable.leadingAnchor)
    lazy var right = DefaultLayoutPropertyProxy(anchor: anchorable.trailingAnchor)
    lazy var centerX = DefaultLayoutPropertyProxy(anchor: anchorable.centerXAnchor)
    lazy var centerY = DefaultLayoutPropertyProxy(anchor: anchorable.centerYAnchor)
    lazy var width = DefaultLayoutPropertyProxy(anchor: anchorable.widthAnchor)
    lazy var height = DefaultLayoutPropertyProxy(anchor: anchorable.heightAnchor)

    /// Initilized the Proxy
    /// - Parameter anchorable: a anchorable (a view or a layoutguide)
    init(anchorable: Anchorable) {
        self.anchorable = anchorable
    }
}
