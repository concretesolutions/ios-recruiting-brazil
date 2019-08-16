//
//  Registrable.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 13/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import UIKit

public protocol Registrable: AnyObject {

    /// Register observers that implements Registrable protocol
    func registerObservers()

    /// Called after registerObservers
    func registerAdditionalObservers()

    /// Unregister observers of ObserservableProtocol and Registrable protocol
    func unregisterObservers()

    /// Called after unregister observers, usually to unregister complex types
    func unregisterAdditionalObservers()
}

extension Registrable {
    public func registerAdditionalObservers() {}
    public func unregisterAdditionalObservers() {}

    public func registerObservers() {
        let mirror = Mirror(reflecting: self)

        for child in mirror.children {
            guard !isDelegate(label: child.label) else {
                continue
            }
            if let registrable = child.value as? Registrable {
                registrable.registerObservers()
            }
        }

        registerAdditionalObservers()
    }

    public func unregisterObservers() {
        let mirror = Mirror(reflecting: self)

        for child in mirror.children {
            guard !isDelegate(label: child.label) else {
                continue
            }
            if let observable = child.value as? ObservableProtocol {
                observable.unbind()
            } else if let registrable = child.value as? Registrable {
                registrable.unregisterObservers()
            }
        }

        unregisterAdditionalObservers()
    }
}

// MARK: - Private
private extension Registrable {
    /// Delegates and datasources can be references from its parent, this is to avoid an infinite loop
    ///
    /// - Parameter label: label description
    /// - Returns: True if it is delegate or datasource label
    func isDelegate(label: String?) -> Bool {
        guard let label = label?.uppercased() else {
            return false
        }

        return label.contains("DELEGATE") || label.contains("DATASOURCE")
    }
}
