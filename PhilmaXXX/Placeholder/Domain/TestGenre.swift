//
//  TestGenre.swift
//  DomainTests
//
//  Created by Guilherme Guimaraes on 26/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

public struct TestGenre {
	public static var genre1: Genre {
		return Genre(id: 1, name: "This is a Test!")
	}
	
	public static var genre1alt: Genre {
		return Genre(id: 1, name: "This is another Test!")
	}
	
	public static var genre2: Genre {
		return Genre(id: 2, name: "This is yet another Test!")
	}
}
