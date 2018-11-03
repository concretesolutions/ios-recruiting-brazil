//
//  ImageCache.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class ImageCache {
    
    static let global = ImageCache()
    
    typealias Callback = (UIImage?) -> Void
    private var images:[String:UIImage?] = [:]
    
    func getImage(for link:String, completion:Callback? = nil) {
        if let img = self.images[link] {
            completion?(img)
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                let img = Assets.getImage(from: link)
                self.images[link] = img
                DispatchQueue.main.async { completion?(img) }
            }
        }
    }
}
