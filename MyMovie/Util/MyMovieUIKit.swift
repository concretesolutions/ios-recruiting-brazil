//
//  MyMovieUIKit.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 20/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

open class MyMovieUIKit : NSObject {
	
	//// Cache
	
	fileprivate struct Cache {
		static let background: UIColor = UIColor.fromHex(0xFFC97B)
		static let text: UIColor = UIColor.fromHex(0x61823f)
		static let lightGreen : UIColor = UIColor.fromHex(0x7EB758)
		static let lightSkyBlue : UIColor = UIColor.fromHex(0x87CEFA)
		
	}
	
	//// Colors
	
	public static var background: UIColor { return Cache.background }
	public static var text: UIColor {return Cache.text }
	public static var lightGreen: UIColor {return Cache.lightGreen }
	public static var lightSkyBlue: UIColor {return Cache.lightSkyBlue }
	
	
	
	//// Fonts

}
