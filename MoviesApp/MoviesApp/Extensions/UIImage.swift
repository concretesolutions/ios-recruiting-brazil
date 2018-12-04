//
//  UIImage.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import UIKit

extension UIImage {
    func proportionalResized(width: CGFloat) -> UIImage {
        if size.width > width {
            let imageRatio = size.height/size.width
            
            let rect = CGRect(x: 0, y: 0, width: width, height: width*imageRatio)
            
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width*imageRatio), false, 1.0)
            draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
        } else {
            return self
        }
    }
}
