//
//  Date.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: - Enums
    
    enum ConversionError: Error {
        case runtimeError(String)
    }
    
    // MARK: - Initializers
    
    init(string: String, format: String = "yyyy-MM-dd") throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let formattedString = dateFormatter.date(from: string) {
            self = formattedString
        } else {
            throw ConversionError.runtimeError("Failed to match string \"\(string)\" for provided format \"\(format)\".")
        }
    }
}
