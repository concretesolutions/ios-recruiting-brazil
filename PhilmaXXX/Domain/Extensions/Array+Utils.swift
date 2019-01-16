//
//  Array+Utils.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 31/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation

extension Array {
	func get(index: Int) -> Element? {
		if 0 <= index && index < count {
			return self[index]
		} else {
			return nil
		}
	}
}
