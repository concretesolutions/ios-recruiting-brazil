//
//  UINavigationBarExtension.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar{
    
    func styleDefault(){
        self.tintColor = UIColor.black
        self.barTintColor = UIColor.hexStringToUIColor(hex: Constants.backgroundColorHexDefaultApp)
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor:self.tintColor]
        //remove line navigationbar
        self.shadowImage = UIImage()
        self.backgroundImage(for: .default)
        
        
    }
}
