//
//  Domain+Utils.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 25/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

fileprivate struct YearValidation {
	static let invalidYear: String = "Ano Inválido"
}

extension Movie {
	public var yearOfRelease: Int? {
		if let releaseDate = releaseDate {
			return Calendar.current.component(.year, from: releaseDate)
		}
		return Date.invalidYear
	}

	public var yearDescription: String {
		if let ano = self.yearOfRelease {
			return ano == Date.invalidYear ? YearValidation.invalidYear : "\(ano)"
		}
		return ""
	}
	
}

extension Date {
	static var invalidYear: Int {
		return -1
	}
}

extension Int {
	public var yearDescription: String {
		return self == Date.invalidYear ? "\(YearValidation.invalidYear)" : "\(self)"
	}
}
