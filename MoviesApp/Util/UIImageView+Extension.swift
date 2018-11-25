//
//  UIImageView+Extension.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 12/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView{
    
    func download(image:String){
        let fullString = "\(APIRequest.fetchImage.rawValue)\(image)"
        
        guard let imageURL = URL(string: fullString) else {return}
        
        self.sd_setImage(with: imageURL, placeholderImage: nil, options: .retryFailed, completed: nil)
        }
    }
