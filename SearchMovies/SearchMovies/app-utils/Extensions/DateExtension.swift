//
//  DateExtension.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

extension Date {
    func Year() -> Int {
        let calendar:NSCalendar = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)!
        return calendar.component(NSCalendar.Unit.year, from: self)
    }
    
    func Month() -> Int {
        let calendar:NSCalendar = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)!
        return calendar.component(NSCalendar.Unit.month, from: self)
    }
    
    func Day() -> Int {
        let calendar:NSCalendar = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)!
        return calendar.component(NSCalendar.Unit.day, from: self)
    }
}
