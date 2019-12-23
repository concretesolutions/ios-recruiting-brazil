//
//  DatesFilterDelegate.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 22/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

protocol DatesFilterDelegate: class {

    // MARK: - properties

    var dates: [String] { get }
    var tempSelectedDates: Set<String> { get set }
}
