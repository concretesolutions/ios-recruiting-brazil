//
//  Date+Components.swift
//  Movs
//
//  Created by Tiago Chaves on 15/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

extension Date {
	
	func getYear() -> String {
	
		let calendar = Calendar.current
		let year = calendar.component(.year, from: self)
		
		return "\(year)"
	}
}
