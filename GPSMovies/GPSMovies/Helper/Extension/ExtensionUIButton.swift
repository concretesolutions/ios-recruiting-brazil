//
//  ExtensionUIButton.swift
//  GPSMovies
//
//  Created by Gilson Santos on 09/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func isEnableButton(_ isEnable: Bool) {
        if isEnable && !self.isEnabled {
            self.pulseAnimation(scaleX: 1.05, scaleY: 1.05, timer: 0.1, alpha: 1, nil)
            self.backgroundColor = UIColor.red
            self.titleLabel?.textColor = UIColor.white
        }else if !isEnable && self.isEnabled{
            self.alpha = 0.54
            self.backgroundColor =  UIColor.lightGray
            self.titleLabel?.textColor = UIColor.white
        }
        self.isEnabled = isEnable
    }

}
