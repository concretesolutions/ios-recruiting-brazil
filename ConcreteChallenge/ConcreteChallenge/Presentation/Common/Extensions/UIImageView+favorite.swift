//
//  UIImageView+favorite.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

enum FavoriteState: String {
    case faved, unfaved
    
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}

extension UIImageView {
    func setStateTo(_ state: FavoriteState) {
        self.image = state.image
        
    }
}
