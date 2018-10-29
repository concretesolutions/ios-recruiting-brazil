//
//  DateFormatterHelper.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 28/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
