//
//  File.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 23/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

extension Date {
    
    var year: Int? {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([Calendar.Component.year], from: self)
            return components.year ?? nil
        }
    }
}
