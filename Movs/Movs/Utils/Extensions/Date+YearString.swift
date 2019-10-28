//
//  Date+YearString.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

extension Date {
    var yearString: String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return "\(year)"
    }
}
