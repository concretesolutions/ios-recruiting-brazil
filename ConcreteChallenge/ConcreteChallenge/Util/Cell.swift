//
//  Cell.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

protocol Cell: ViewCode { // should be a type restricting to table ou collection view cell
    associatedtype ViewModelType: ViewModel

    var viewModel: ViewModelType? { get set }
}
