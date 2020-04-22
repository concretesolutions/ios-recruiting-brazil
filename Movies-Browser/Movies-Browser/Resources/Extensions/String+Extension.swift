//
//  String+Extension.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 19/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

extension String {
    /// Function that returns a date from String with specified format.
    public func dateFromText(format: String = "yyyy-MM-dd") -> Date? {
        let dateText: String? = self
        guard let unwrappedDateText = dateText, !unwrappedDateText.isEmpty else { return Date() }
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = format
        
        if let date = formatter.date(from: unwrappedDateText) {
            return date
        }
        
        return Date()
    }
}
