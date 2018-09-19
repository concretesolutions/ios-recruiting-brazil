//
//  UIImage+Helpers.swift
//  Movs
//
//  Created by Lucas Ferraço on 19/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

extension UIImage {
	public func grayMultiply() -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		let renderer = UIGraphicsImageRenderer(size: size)
		
		return renderer.image { ctx in
			// fill the background with white so that translucent colors get lighter
			UIColor.darkGray.set()
			ctx.fill(rect)
			
			draw(in: rect, blendMode: .multiply, alpha: 1)
		}
	}
}
