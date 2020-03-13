//
//  LoadImageWithCache.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

class LoadImageWithCache {

    // MARK: - Constants

    let imageCache = NSCache<NSString, AnyObject>()
    static var shared = LoadImageWithCache()
    
    // MARK: - Properties

    var imageURLString: String?
    
    func downloadMovieAPIImage(posterUrl: String, imageView: UIImageView, completion: @escaping (Result<MoviePosterResponse, ResponseError>) -> Void) {
        let urlConcat = "https://image.tmdb.org/t/p/w500" + posterUrl
        let url = URL(string: urlConcat)
        if let imageFromCache = imageCache.object(forKey: (urlConcat as AnyObject) as! NSString) as? UIImage {
            imageView.image = imageFromCache
            let poster = MoviePosterResponse.init(banner: imageView.image!)
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
            self.imageCache.setObject(downloadedImage, forKey: (urlConcat as AnyObject) as! NSString)
            let image = MoviePosterResponse.init(banner: downloadedImage)
            completion(Result.success(image))
        }).resume()
    }
    
}
