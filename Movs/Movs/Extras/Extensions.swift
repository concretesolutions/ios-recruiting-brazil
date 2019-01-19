//
//  Extensions.swift
//  Movs
//
//  Created by vinicius emanuel on 16/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor{
    public class func RGBColor(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}
