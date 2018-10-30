//
//  JSONDecoder+Models.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 22/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation

extension JSONDecoder {
	public static var standardDecoder: JSONDecoder {
		let decoder = JSONDecoder()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		decoder.dateDecodingStrategy = .formatted(dateFormatter)
		
		return decoder
	}
}
