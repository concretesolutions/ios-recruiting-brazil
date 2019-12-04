//
//  UIImageView+Cache.swift
//  movies
//
//  Created by Jacqueline Alves on 04/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

extension UIImageView {
    /// Load an image from URL on Image View
    /// Get image from cache if exists and download it if it doesn't
    /// - Parameter url: Image URL
    public func loadImage(from url: URL) {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        DispatchQueue.global(qos: .userInitiated).async { // Enter on user initiate queue so doens't block app UI
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) { // Check if image is already on cache
                DispatchQueue.main.async {
                    self.transition(toImage: image) // Replace image smoothly
                }
            } else {
                URLSession.shared.dataTask(with: request) { (data, response, _) in
                    // Check if data and response were valid and try to create image with data
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        
                        cache.storeCachedResponse(cachedData, for: request) // Stores the response on cache
                        
                        DispatchQueue.main.async {
                            self.transition(toImage: image) // Replace image smoothly
                        }
                    }
                }
            }
        }
    }
    
    /// Makes a smooth transition of image on Image View
    /// - Parameter image: Image to be placed on Image View
    public func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.image = image
        }, completion: nil)
    }
}
