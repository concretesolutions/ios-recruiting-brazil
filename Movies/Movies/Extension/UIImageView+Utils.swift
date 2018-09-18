//
//  UIImageView+Utils.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Alamofire
import AlamofireImage
import Foundation
import UIKit

extension UIImageView {
    
    // Loads an URL to the UIImageVIew
    func load(_ url: String?){
        DataRequest.addAcceptableImageContentTypes(["image/*"])
        self.image = nil
        if let urlImage = url, let urlImagePath = URL(string: urlImage) {
            self.af_setImage(withURL: urlImagePath, placeholderImage: nil, filter: nil, imageTransition: .crossDissolve(0.1), completion: nil)
        }
    }
}
