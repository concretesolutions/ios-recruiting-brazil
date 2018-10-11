//
//  UIImage+Extension.swift
//  DataMovie
//
//  Created by Andre Souza on 13/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

extension UIImage {
    class func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1.5)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return img
            }
        }
        
        return UIImage()
    }
}
