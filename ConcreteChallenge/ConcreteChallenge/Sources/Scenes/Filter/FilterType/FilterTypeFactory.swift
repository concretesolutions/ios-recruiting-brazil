//
//  FilterTypeFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum FilterTypeFactory {
    static func makeFilterType() -> UIViewController {
        let filterTypeViewController = FilterTypeViewController()

        return filterTypeViewController
    }
}
