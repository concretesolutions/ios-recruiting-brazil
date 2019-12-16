//
//  ErrorDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 16/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

/// Protocol to display error messages.
protocol ErrorDelegate {
    
    /**
     Inform the user something went wrong.
     - Parameter type: The message type to display.
     */
    func displayError(_ type: ErrorMessageType)
    
    /// Hide any error messages that may be currently displayed.
    func hideError()
}
