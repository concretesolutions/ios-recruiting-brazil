//
//  ConstraintsChain.swift
//  Constraints
//
//  Created by Serhiy Vysotskiy on 12/24/17.
//  Copyright © 2017 Serhiy Vysotskiy. All rights reserved.
//

/// The very engine for constrainting
public final class ConstraintsChain {
    public var constraints: [NSLayoutConstraint] = []
    public init() {}
    
    public static var constantsScale: CGFloat {
        set { scale = newValue }
        get { scale }
    }
    
    public static var isPixelPerfect: Bool {
        set { shouldRoundToPixelPerfect = newValue }
        get { shouldRoundToPixelPerfect }
    }
    
    public var safeAreaInsets: UIEdgeInsets {
        set { safeMargins = newValue }
        get { safeMargins }
    }
    
    deinit {
        let active = constraints.allSatisfy { $0.isActive }
        if !active { activate() }
    }
}

var scale: CGFloat = 1
var shouldRoundToPixelPerfect = false

func makePixelPerfect(_ constant: CGFloat) -> CGFloat {
    guard shouldRoundToPixelPerfect else { return constant }
    var result: CGFloat
    switch constant {
    case 0:
        result = 0
    case -0.5...0.5:
        result = 0.5 * (constant / abs(constant))
    default:
        result = constant.rounded(.awayFromZero)
    }
    
    return result
}

// MARK: - Basic pin method
extension ConstraintsChain {
    public func pin(on s: UIView, attribute a1: NSLayoutConstraint.Attribute, of v1: UIView, to a2: NSLayoutConstraint.Attribute, of v2: UIView?, r: NSLayoutConstraint.Relation = .equal, c: CGFloat = 0, m: CGFloat = 1) {
        
        if let v2 = v2 {
            let shouldCheck = !doesHaveCommonSuperview(v1, v2)
            check(v1, on: s, shouldCheckForSuperview: shouldCheck)
            check(v2, on: s, shouldCheckForSuperview: shouldCheck)
        } else {
            check(v1, on: s, shouldCheckForSuperview: true)
        }
        
        let constant = shouldRoundToPixelPerfect ? makePixelPerfect(c * scale) : c * scale
        let constraint = NSLayoutConstraint(item: v1, attribute: a1, relatedBy: r, toItem: v2, attribute: a2, multiplier: m, constant: constant)
        constraints.append(constraint)
    }
    
    private func check(_ view: UIView, on superview: UIView, shouldCheckForSuperview: Bool) {
        if !(view.superview === superview || view === superview || !shouldCheckForSuperview) {
            superview.addSubview(view)
        }
        
        if view !== superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func doesHaveCommonSuperview(_ v1: UIView, _ v2: UIView) -> Bool {
        let svids = { (view: UIView) -> Set<Int> in
            var res = Set<Int>()
            var sv = view.superview
            while let hash = sv?.hashValue {
                res.insert(hash)
                sv = sv?.superview
            }
            
            return res
        }
        
        return !svids(v1).intersection(svids(v2)).isEmpty
    }
}

// MARK: - Activate/Deactivate constraints
extension ConstraintsChain {
    public func activate() {
        NSLayoutConstraint.activate(constraints)
    }
    
    public func deactivate() {
        NSLayoutConstraint.deactivate(constraints)
    }
}

// MARK: - Constraint conversion
extension ConstraintsChain {
    public func chain(with other: Constraint) -> Constraint {
        return Constraint(view: other.view, superview: other.superview, constraintsChain: merged(other.constraintsChain), constraint: other.constraint)
    }
    
    public func chain(with view: UIView, on superview: UIView) -> Constraint {
        return Constraint(view: view, superview: superview, constraintsChain: self)
    }
    
    public func merged(_ other: ConstraintsChain) -> ConstraintsChain {
        constraints.append(contentsOf: other.constraints)
        return self
    }
}

// MARK: - Convenience constrainting methods
extension ConstraintsChain {
    @discardableResult
    public func centerX(on s: UIView, views vs: [UIView], in p: UIView? = nil, c: CGFloat = 0, m: CGFloat = 1) -> ConstraintsChain {
        vs.forEach { view in
            pin(on: s, attribute: .centerX, of: view, to: .centerX, of: p ?? s, r: .equal, c: c, m: m)
        }
        
        return self
    }
    
    @discardableResult
    public func centerY(on s: UIView, views vs: [UIView], in p: UIView? = nil, c: CGFloat = 0, m: CGFloat = 1) -> ConstraintsChain {
        vs.forEach { view in
            pin(on: s, attribute: .centerY, of: view, to: .centerY, of: p ?? s, r: .equal, c: c, m: m)
        }
        
        return self
    }
    
    @discardableResult
    public func center(on s: UIView, views vs: [UIView], in p: UIView? = nil, c: CGFloat = 0, m: CGFloat = 1) -> ConstraintsChain {
        return centerX(on: s, views: vs, in: p, c: c, m: m)
            .centerY(on: s, views: vs, in: p, c: c, m: m)
    }
}
