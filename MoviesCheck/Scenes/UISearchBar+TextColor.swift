//
//  UISearchBar+TextColor.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

extension UISearchBar {
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}
