//
//  UIImageView+ImageForURL.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 02/11/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    func imageForURL(_ url: URL?, _ supportURL: URL? = nil) {
        guard let url = url else {
            return
        }
        self.sd_setImage(with: url) { _, err, _, _ in
            if err != nil {
                if supportURL != nil {
                    self.sd_setImage(with: supportURL, completed: nil)
                }
                
            }
        }
    }
}
