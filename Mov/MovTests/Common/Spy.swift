//
//  Spy.swift
//  MovTests
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol Spy {
    associatedtype MockMethod: Hashable
    var calls: Set<MockMethod> { get }
    func didCall(method: MockMethod) -> Bool
}

extension Spy {
    func didCall(method: MockMethod) -> Bool {
        return self.calls.contains(method)
    }
}
