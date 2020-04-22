//
//  UIView+Extension.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 20/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

extension UIView {
    /// Function that returns a generic UIView from a specific Xib File.
    class func initFromNib<T: UIView>(frame: CGRect) -> T {
        let view = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = frame
        return view
    }
}
