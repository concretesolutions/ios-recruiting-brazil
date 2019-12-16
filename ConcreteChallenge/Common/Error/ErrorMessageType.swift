//
//  ErrorMessageType.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 16/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

/// A type of error message to display
enum ErrorMessageType {
    
    /// Display a generic error message
    case generic
    
    /// Inform the user some information about the error
    case info(_ message: String)
    
    /// Inform that some info is missing
    case missing(_ message: String)
}
