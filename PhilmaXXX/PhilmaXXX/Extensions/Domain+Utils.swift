//
//  Domain+Utils.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 25/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

extension Movie {
	public var yearOfRelease: Int {
		return Calendar.current.component(.year, from: releaseDate)
	}
}
