//
//  CAGradientLayer.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor], isTopToBottom:Bool = true) {
        self.init()
        self.frame = frame
        self.colors = []
        colors.forEach { color in
            self.colors?.append(color.cgColor)
        }
        
        if isTopToBottom {
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: 1)
        } else {
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 1, y: 0)
        }
        
    }
    
    func creatGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
