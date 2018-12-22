//
//  UImage+SDWebImage.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView{
    func downloadImage(with path: String){
        self.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + path), placeholderImage: UIImage(named: "Splash"), options: .progressiveDownload)
    }
}
