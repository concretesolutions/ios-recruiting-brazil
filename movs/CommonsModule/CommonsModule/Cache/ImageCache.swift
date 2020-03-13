//
//  ImageCache.swift
//  CommonsModule
//
//  Created by Marcos Felipe Souza on 13/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

public class ImageCache {
    
    public static let shared = ImageCache()
    private init(){}
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    
    public func setImage(_ image: UIImage, in key: String) {
        let nsKey = key as NSString
        self.imageCache.setObject(image, forKey: nsKey)
    }
    
    public func getImage(in key: String) -> UIImage? {
        let nsKey = NSString(string: key)
        if let cachedImage = imageCache.object(forKey: nsKey) {
            return cachedImage
        }
        return nil
    }
}

