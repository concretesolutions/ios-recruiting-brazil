//
//  UIView+Constrains.swift
//  Movs
//
//  Created by Maisa on 30/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//
import UIKit

extension UIView {
    
    @discardableResult func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func heightAnchor(equalTo height: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult func widthAnchor(equalTo width: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult func heightAnchor(equalTo dimension: NSLayoutDimension, multiplier: CGFloat) -> Self {
        heightAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult func widthAnchor(equalTo dimension: NSLayoutDimension, multiplier: CGFloat) -> Self {
        widthAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
}
