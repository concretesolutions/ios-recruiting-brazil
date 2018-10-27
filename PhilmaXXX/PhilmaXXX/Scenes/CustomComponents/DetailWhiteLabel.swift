//
//  DetailWhiteLabel.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import UIKit

final class DetailWhiteLabel: UILabel {
	
	private let topInset: CGFloat = 4.0
	private let bottomInset: CGFloat = 4.0
	private let leftInset: CGFloat = 8.0
	private let rightInset: CGFloat = 8.0

	override init(frame: CGRect) {
		super.init(frame: frame)
		baseInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		baseInit()
	}
	
	func baseInit(){
		self.font = UIFont(name: "Lucida Grande", size: 40)
		self.font = self.font.withSize(40)
		self.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
		self.textColor = .white
		self.textAlignment = .left
		self.numberOfLines = 0
		self.shadowColor = .black
		self.shadowOffset = CGSize(width: 1, height: 1)
		self.adjustsFontSizeToFitWidth = true
	}
	
	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
		super.drawText(in: rect.inset(by: insets))
	}
}
