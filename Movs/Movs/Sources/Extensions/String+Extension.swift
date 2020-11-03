//
//  String+Extension.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

public extension String {
    static let empty = ""
    static let space = " "
    static let comma = ","

    // MARK: - Computed variables

    var year: String {
        let calendar = Calendar.current
        return String(calendar.component(.year, from: toDate()))
    }

    // MARK: - Functions

    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Utils.dateFormat

        return dateFormatter.date(from: self) ?? Date()
    }
}
