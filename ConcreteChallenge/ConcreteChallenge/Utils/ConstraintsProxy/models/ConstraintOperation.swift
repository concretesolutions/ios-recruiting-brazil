//
//  ConstraintOperation.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// This are the two types of operation with constraint, multiply: for dimension constraints and margin for all of them.
enum ConstraintOperation {
    case multiply(CGFloat), margin(CGFloat)
}
