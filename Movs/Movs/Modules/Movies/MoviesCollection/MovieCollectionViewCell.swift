//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var outletActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var outletMovieImage: UIImageView!
    @IBOutlet weak var outletMovieTitle: UILabel!
    
    func awakeFromNib(title: String, imageURL: String?) {
        super.awakeFromNib()
        self.outletMovieTitle.text = title
        if let image = imageURL {
            loadImage(imageURL: image)
        }
    }
    
    func showImage(movieImage: UIImage) {
        self.outletActivityIndicator.stopAnimating()
        self.outletMovieImage.image = movieImage
    }
    
    func loadImage(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                //completion(nil)
                return
            }
            DispatchQueue.main.async  {
                if let downloadedImage = UIImage(data: data!) {
                    //completion(downloadedImage)
                    self.showImage(movieImage: downloadedImage)
                }
            }
        }.resume()
    }
    
}
