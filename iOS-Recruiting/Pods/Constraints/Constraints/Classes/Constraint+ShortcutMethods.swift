//
//  Constraint+ShortcutMethods.swift
//  Constraints
//
//  Created by Serhiy Vysotskiy on 16.01.2018.
//  Copyright © 2018 vysotskiyserhiy. All rights reserved.
//

import UIKit

extension Constraint {
    @discardableResult
    public func pin(same a: NSLayoutConstraint.Attribute, as v: UIView?, r: NSLayoutConstraint.Relation = .equal, c: CGFloat = 0, m: CGFloat = 1) -> Constraint {
        constraintsChain.pin(on: superview, attribute: a, of: view, to: a, of: v, r: r, c: c, m: m)
        return Constraint(view: view, superview: superview, constraintsChain: constraintsChain, constraint: constraintsChain.constraints.last)
    }
    
    @discardableResult
    public func pin(_ a: NSLayoutConstraint.Attribute, toTopOf v: UIView?, r: NSLayoutConstraint.Relation = .equal, c: CGFloat = 0, m: CGFloat = 1) -> Constraint {
        constraintsChain.pin(on: superview, attribute: a, of: view, to: .top, of: v, r: r, c: c, m: m)
        return Constraint(view: view, superview: superview, constraintsChain: constraintsChain, constraint: constraintsChain.constraints.last)
    }
    
    @discardableResult
    public func pin(_ a: NSLayoutConstraint.Attribute, toBottomOf v: UIView?, r: NSLayoutConstraint.Relation = .equal, c: CGFloat = 0, m: CGFloat = 1) -> Constraint {
        constraintsChain.pin(on: superview, attribute: a, of: view, to: .bottom, of: v, r: r, c: c, m: m)
        return Constraint(view: view, superview: superview, constraintsChain: constraintsChain, constraint: constraintsChain.constraints.last)
    }
    
    @discardableResult
    public func pin(_ a: NSLayoutConstraint.Attribute, toLeftOf v: UIView?, r: NSLayoutConstraint.Relation = .equal, c: CGFloat = 0, m: CGFloat = 1) -> Constraint {
        constraintsChain.pin(on: superview, attribute: a, of: view, to: .left, of: v, r: r, c: c, m: m)
        return Constraint(view: view, superview: superview, constraintsChain: constraintsChain, constraint: constraintsChain.constraints.last)
    }
    
    @discardableResult
    public func pin(_ a: NSLayoutConstraint.Attribute, toRightOf v: UIView?, r: NSLayoutConstraint.Relation = .equal, c: CGFloat = 0, m: CGFloat = 1) -> Constraint {
        constraintsChain.pin(on: superview, attribute: a, of: view, to: .right, of: v, r: r, c: c, m: m)
        return Constraint(view: view, superview: superview, constraintsChain: constraintsChain, constraint: constraintsChain.constraints.last)
    }
}
