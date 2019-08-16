//
//  OSLog+Movs.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 13/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import os

extension OSLog {

    private static let applicationIdentifier = "com.movs"

    public static var configuration: OSLog {
        return OSLog(subsystem: applicationIdentifier, category: "configuration")
    }

    public static var database: OSLog {
        return OSLog(subsystem: applicationIdentifier, category: "database")
    }

    public static var general: OSLog {
        return OSLog(subsystem: applicationIdentifier, category: "general")
    }

    public static var networking: OSLog {
        return OSLog(subsystem: applicationIdentifier, category: "networking")
    }
}
