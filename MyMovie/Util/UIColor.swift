//
//  UIColor.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 20/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

public extension UIColor {
	// For any hex code 0xXXXXXX and alpha value,
	// return a matching UIColor
	public static func fromHex(_ rgbValue:UInt32, alpha:Double = 1.0) -> UIColor {
		let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
		let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
		let blue = CGFloat(rgbValue & 0xFF)/256.0
		
		return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
	}
	
	func colorWithHue(_ newHue: CGFloat) -> UIColor {
		var saturation: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
		self.getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		return UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha)
	}
	
	func colorWithSaturation(_ newSaturation: CGFloat) -> UIColor {
		var hue: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
		self.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
		return UIColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
	}
	
	func colorWithBrightness(_ newBrightness: CGFloat) -> UIColor {
		var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, alpha: CGFloat = 1.0
		self.getHue(&hue, saturation: &saturation, brightness: nil, alpha: &alpha)
		return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
	}
	
	func colorWithAlpha(_ newAlpha: CGFloat) -> UIColor {
		var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, brightness: CGFloat = 1.0
		self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
		return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
	}
	
	func colorWithHighlight(_ highlight: CGFloat) -> UIColor {
		var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
		self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		return UIColor(red: red * (1-highlight) + highlight, green: green * (1-highlight) + highlight, blue: blue * (1-highlight) + highlight, alpha: alpha * (1-highlight) + highlight)
	}
	
	func colorWithShadow(_ shadow: CGFloat) -> UIColor {
		var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
		self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		return UIColor(red: red * (1-shadow), green: green * (1-shadow), blue: blue * (1-shadow), alpha: alpha * (1-shadow) + shadow)
	}
	
}

