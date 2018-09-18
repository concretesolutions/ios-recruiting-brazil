//
//  DateUtil.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class DateUtil {
    static func convertDateStringToString(dateString: String, formatter: String, toFormatter: String) -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormatter
        let dateFormatted = dateFormatter.string(from: date)
        
        return dateFormatted
    }
}
