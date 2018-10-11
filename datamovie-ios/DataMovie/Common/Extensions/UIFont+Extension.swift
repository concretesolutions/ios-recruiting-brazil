//
//  UIFont+Extension.swift
//  DataMovie
//
//  Created by Andre on 12/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

extension UIFont {
    
    convenience init(type: DMFont, size: CGFloat) {
        self.init(name: type.rawValue, size: size)!
    }

}
