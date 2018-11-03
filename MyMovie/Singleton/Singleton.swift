//
//  Singleton.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 25/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

class Singleton: NSObject {
	
	static let sharedInstance: Singleton = Singleton()
	
	var movies : [Movie] = []
	var genres : [Genre] = []
}
