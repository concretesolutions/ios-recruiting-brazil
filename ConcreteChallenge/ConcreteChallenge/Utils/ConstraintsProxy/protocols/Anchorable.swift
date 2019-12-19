//
//  Anchorable.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// An anchorable is any type that has Anchors. These types are both: the UIView and UILayoutGuide.
/// This protocol was done for referring to UIViews and UILayoutGuides using the same reference type and then to reuse code.
/// So the LayoutProxy can work for both: UIViews and UILayoutGuides.
protocol Anchorable {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    
    var layout: LayoutProxy { get } 
}

extension UIView: Anchorable { }
extension UILayoutGuide: Anchorable { }
