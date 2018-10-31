//
//  DateParser.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 31/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation

public class DateParser {
	static func parseDateWithFormat(date YYYYMMDD: String?, separator: String) -> Date?{
		let parsedDate = (YYYYMMDD ?? "").components(separatedBy: separator)
		if let year = parsedDate.get(index: 0), let month = parsedDate.get(index: 1), let day = parsedDate.get(index: 2){
			let dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, era: nil, year: Int(year), month: Int(month), day: Int(day), hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
			return Calendar.current.date(from: dateComponents)
		}
		return nil
	}
	
}
