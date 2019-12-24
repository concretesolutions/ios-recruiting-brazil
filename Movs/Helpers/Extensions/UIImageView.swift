//
//  UIImageView.swift
//  Movs
//
//  Created by Gabriel D'Luca on 07/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func download(imageURL url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: ImageResource(downloadURL: imageURL), options: [
            .transition(.fade(0.5))
        ]) { result in
            switch result {
            case .failure:
                self.image = UIImage(named: "placeholder")
            case .success(let result):
                self.image = result.image
            }
        }
    }
}
