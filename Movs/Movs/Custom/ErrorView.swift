//
//  ErrorView.swift
//  Movs
//
//  Created by Tiago Chaves on 14/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class ErrorView: UIView {
	
	convenience init(forView view:UIView, withMessage message:String?) {
		
		let viewSize = view.frame.size
		let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: viewSize)
		
		self.init(frame: frame)
		
		let imageWidth:CGFloat = 100.0
		let imageHeight:CGFloat = 100.0
		let imageY:CGFloat = 110.0
		
		let imageView = UIImageView(frame: CGRect(x: (viewSize.width / 2) - (imageWidth / 2), y: imageY, width: imageWidth, height: imageHeight))
		imageView.image = UIImage(named: "error_icon")
		imageView.contentMode = .scaleAspectFit
		
		let labelWidth:CGFloat = viewSize.width - 24
		let labelHeight:CGFloat = 100
		
		let label = UILabel(frame: CGRect(x: (viewSize.width / 2) - (labelWidth / 2), y: imageY + imageHeight, width: labelWidth, height: labelHeight))
		
		label.text          		= message ?? ""
		label.textColor     		= UIColor.black
		label.backgroundColor 		= UIColor.white
		label.textAlignment 		= .center
		label.numberOfLines 		= 3
		label.font = UIFont(name: "Futura-Medium", size: 19.0)
		
		addSubview(imageView)
		addSubview(label)
	}
}
