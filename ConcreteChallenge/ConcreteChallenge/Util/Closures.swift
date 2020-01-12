//
//  Closures.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

typealias VoidClosure = () -> Void

typealias ErrorClosure = (Error) -> Void

typealias MovieClosure = (Movie) -> Void

typealias ImageClosure = (UIImage?) -> Void

typealias MovieCellViewModelClosure = ([MovieCellViewModel]) -> Void
