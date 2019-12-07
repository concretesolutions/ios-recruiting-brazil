//
//  Logger.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

/// Wrapper class for os_log function
struct Logger {
    /// Create OSLog with subsystem and category
    static func osLog(subsystem: String = Bundle.main.bundleIdentifier ?? "-", category: String) -> OSLog {
        return OSLog(subsystem: subsystem, category: category)
    }

    /// Create app log
    static func appLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.app)
    }

    /// Create networking log
    static func networkingLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.networking)
    }

    /// Create lifecycle log
    static func lifecycleLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.lifecycle)
    }
}
