//
//  CGFloat + proportionalToWidth.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

import UIKit

extension CGFloat {
    
    var proportionalToWidth: CGFloat {
        return self * UIScreen.widthProportion
    }
}
