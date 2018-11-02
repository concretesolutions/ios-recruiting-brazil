//
//  ImageCache.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class ImageCache {
    
    private var images:[String:UIImage?] = [:]
    
    func getImage(for link:String) -> UIImage? {
        if let img = self.images[link] {
            return img
        } else {
            let img = Assets.getImage(from: link)
            self.images[link] = img
            return img
        }
    }
}
