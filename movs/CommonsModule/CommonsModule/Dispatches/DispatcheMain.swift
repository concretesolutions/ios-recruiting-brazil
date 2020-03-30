//
//  DispatcheMain.swift
//  CommonsModule
//
//  Created by Marcos Felipe Souza on 30/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

/// performUI is for Test
/// DispatchQueue.main.async(execute: closure) stop all over Unit Test
/// performUI doen't stop the Unit Tests.
public func performUIUpdate(using closure: @escaping () -> Void) {
    // If we are already on the main thread, execute the closure directly
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: closure)
    }
}
