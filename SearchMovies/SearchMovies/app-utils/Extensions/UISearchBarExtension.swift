//
//  UISearchBarExtension.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    func styleDefault() {
       //self.tintColor = UIColor.black
       self.barTintColor = UIColor.hexStringToUIColor(hex: Constants.backgroundColorHexDefaultApp)
        self.tintColor = UIColor.hexStringToUIColor(hex: Constants.backgroundColorHexDefaultApp)
    }
}
