//
//  Date+CurrentYear.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 02/05/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation

extension Date {

    static var currentYear: Int {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        return Int(format.string(from: date))!
    }
}
