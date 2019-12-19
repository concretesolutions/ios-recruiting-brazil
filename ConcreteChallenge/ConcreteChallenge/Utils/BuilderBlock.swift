//
//  BuilderBlock.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// It defines a convenience method for making easy reusing setup closures.
protocol BuilderBlock: AnyObject { }

extension BuilderBlock {
    typealias SetupBlock = ((_ self: Self) -> Void)
    
    /// executes a block that builds any object and returns the set object
    /// - Parameter block: the block with the object changes
    @discardableResult
    func build(block: SetupBlock) -> Self {
        block(self)
        
        return self
    }
}

extension NSObject: BuilderBlock {}
