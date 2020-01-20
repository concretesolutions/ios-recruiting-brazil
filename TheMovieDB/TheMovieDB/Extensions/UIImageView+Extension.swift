//
//  UIImageView+Extension.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 12/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public enum DimensionDownloadImage: String {
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
        case original
    }
    
    public func downloadImage(withPath: String,
                              withDimension dimension: DimensionDownloadImage) {
        self.image = UIImage.init(named: "placeholder-movies")
        let path = "\(ServiceAPIManager.PathsAPI.PathImages.secureBaseUrl)\(dimension.rawValue)\(withPath)"
        
        guard let url = URL.init(string: path) else { return }
        ServiceAPIManager.get(url: url) { (data, error) in
            guard error == nil, let imageData = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage.init(data: imageData)
            }
        }
    }
    
    public func generateImageSequence(withPath path: String,
                                      andRange range: ClosedRange<Int>) -> [UIImage] {
        var images: [UIImage] = []
        
        for index in range {
            guard let image = UIImage.init(named: "\(path)\(index)") else {continue}
            images.append(image)
        }
        return images
    }
}
