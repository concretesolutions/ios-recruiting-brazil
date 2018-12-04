//
//  ImageServiceConfig.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import UIKit

struct ImageServiceConfig {
    let safeUrl: String
    let availableSizes: [Int]
    
    func makeURL(with path: String, width: Int) -> URL? {
        var imageSize: Int?
        for size in availableSizes.sorted(by: {return $0 < $1}) {
            if size > width && size < (imageSize ?? Int.max) {
                imageSize = size
            }
        }
        var sizeString: String!
        if imageSize != nil {
            sizeString = "w\(imageSize!)"
        } else {
            sizeString = "original"
        }
        return URL(string: safeUrl + sizeString + path)
    }
    
    static func defaultURL(with path: String, width: Int) -> URL? {
        if let currentConfig = AppDelegate.shared.imageServiceConfig {
            return currentConfig.makeURL(with: path, width: width*Int(UIScreen.main.scale))
        }
        
        return URL(string: "https://image.tmdb.org/t/p/" + "original" + path + "?api_key=\(BaseService.moviedbApiKey)")
    }
}
