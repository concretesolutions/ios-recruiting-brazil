//
//  UIImageView+Movs.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import SDWebImage
import UIKit

extension UIImageView {

    func downloadImage(with path: String) {
        self.sd_setImage(with: URL(string: MovieApiConfig.EndPoint.image + path), placeholderImage: UIImage(named: "Splash"), options: .progressiveLoad)
    }
}
