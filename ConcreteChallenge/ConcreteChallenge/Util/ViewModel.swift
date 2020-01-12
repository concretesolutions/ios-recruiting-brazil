//
//  ViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 21/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype ViewState
    associatedtype ModelType

    var state: ViewState { get }
    var model: ModelType { get }
}
