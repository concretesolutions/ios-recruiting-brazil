//
//  ViewCodable.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// A protocol for views made with ViewCode.
/// The views must have the three below methods and must call the setupView in some appropriate place(at init or didMoveToSuperView method, for example).
protocol ViewCodable {
    /// Add code to build the view and subviews Hierarchy
    func buildHierarchy()
    
    /// Add code that makes the constraints setup
    func addConstraints()
    
    /// Add code that makes non-hierachy and layout changes on the View
    func applyAditionalChanges()
}

extension ViewCodable {
    func setupView() {
        self.buildHierarchy()
        self.addConstraints()
        self.applyAditionalChanges()
    }
    
    func applyAditionalChanges() { }
}
