//
//  CGFloat+Screen.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 22/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit

public class ScreenSize {
	static func width() -> CGFloat {
		return UIScreen.main.bounds.width
	}
	
	static func height() -> CGFloat {
		return UIScreen.main.bounds.height
	}
}
