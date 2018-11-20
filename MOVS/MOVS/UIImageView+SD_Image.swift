//
//  UIImageView+SD_Image.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 20/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView{
    func getPoster(forFilm film: ResponseFilm, andActivity activity: UIActivityIndicatorView){
        guard let posterPath = film.poster_path else {
            print("Error trying to get poster path image in: \(UIImageView.self)")
            return
        }
        activity.startAnimating()
        self.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")) { (image, error, cacheType, url) in
            if error == nil {
                activity.stopAnimating()
                activity.alpha = 0
            }else{
                print("Error trying to get poster in: \(UIImageView.self)")
            }
        }
    }
}
