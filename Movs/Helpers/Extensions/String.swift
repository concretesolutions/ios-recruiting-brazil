//
//  String.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

extension String {
    init(date: Date, format: String = "yyyy-MM-dd") {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        self = formatter.string(from: date)
    }
}
