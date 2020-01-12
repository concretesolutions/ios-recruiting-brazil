//
//  UIView+Constraints.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

// MARK: - Anchoring views with constraints
extension UIView {
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: top, constant: padding).isActive = true
        return self
    }

    @discardableResult
    func anchor(left: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: left, constant: padding).isActive = true
        return self
    }

    @discardableResult
    func anchor(bottom: NSLayoutYAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: bottom, constant: -padding).isActive = true
        return self
    }

    @discardableResult
    func anchor(right: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: right, constant: -padding).isActive = true
        return self
    }

    @discardableResult
    func anchor(leading: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: leading, constant: padding).isActive = true
        return self
    }

    @discardableResult
    func anchor(trailing: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAnchor.constraint(equalTo: trailing, constant: -padding).isActive = true
        return self
    }

    @discardableResult
    func anchor(centerX: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: centerX, constant: padding//(paddingLeft ?? 0) - (paddingRight ?? 0)
        ).isActive = true
        return self
    }

    @discardableResult
    func anchor(centerY: NSLayoutYAxisAnchor, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: centerY, constant: padding//(paddingTop ?? 0) - (paddingBottom ?? 0)
        ).isActive = true
        return self
    }

    @discardableResult
    func anchor(widthConstant: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        return self
    }

    @discardableResult
    func anchor(heightConstant: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        return self
    }

    @discardableResult
    func anchor(width: NSLayoutDimension, padding: CGFloat = 0) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: width, constant: -padding).isActive = true
        return self
    }

    @discardableResult
    func anchor(height: NSLayoutDimension) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: height).isActive = true
        return self
    }

    @discardableResult
    func anchor(aspectRatio: CGFloat) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: aspectRatio).isActive = true
        return self
    }
}
