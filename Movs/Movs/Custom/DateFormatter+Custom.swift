//
//  DateFormatter+Custom.swift
//  Movs
//
//  Created by Tiago Chaves on 15/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

extension DateFormatter {
	
	static let ymd: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
}
