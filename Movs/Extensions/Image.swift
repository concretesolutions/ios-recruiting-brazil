//
//  Image.swift
//  Movs
//
//  Created by Filipe Merli on 20/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

let imgCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadImageWithUrl(posterUrl: String, completion: @escaping (Result<MoviePosterResponse, ResponseError>) -> Void) {
        let urlConcat = "https://image.tmdb.org/t/p/w500" + posterUrl
        let url = URL(string: urlConcat)
        image = nil
        if let imageFromCache = imgCache.object(forKey: urlConcat as AnyObject) as? UIImage {
            self.image = imageFromCache
            let poster = MoviePosterResponse.init(banner: self.image!)
            completion(Result.success(poster))
            return
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(ResponseError.rede))
                    return
            }
            let downloadedImage = UIImage(data: data)!
            imgCache.setObject(downloadedImage, forKey: urlConcat as AnyObject)
            let image = MoviePosterResponse.init(banner: downloadedImage)
            completion(Result.success(image))
        }).resume()
    }
    
}

extension CALayer {
    func addBorders(_ edge: UIRectEdge) {
        let subLayer = CALayer()
        subLayer.frame = CGRect(x: 0, y: frame.height - CGFloat(0.5), width: frame.width, height: CGFloat(0.5))
        subLayer.backgroundColor = UIColor.lightGray.cgColor
        self.addSublayer(subLayer)
        
    }
}
