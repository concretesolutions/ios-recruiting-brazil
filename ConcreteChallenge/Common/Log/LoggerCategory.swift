//
//  LoggerCategory.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

/// Contains pre-defined OSLog categories
struct LoggerCategory {
    /// Generic app logging category
    static var app: String { return "App" }
    /// Networking logging category
    static var networking: String { return "Networking" }
    /// Lifecycle logging category
    static var lifecycle: String { return "Lifecycle" }
}
