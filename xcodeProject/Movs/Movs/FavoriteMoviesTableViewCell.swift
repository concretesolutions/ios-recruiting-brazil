//
//  FavoriteMoviesTableViewCell.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 11/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesTableViewCell: UITableViewCell {
    let releaseLabelGradientHeight: CGFloat = 20.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView! {
        didSet {
            let imageSize = self.posterImage.frame.width
            
            self.posterImage.layer.cornerRadius = imageSize / 2
            self.posterImage.layer.masksToBounds = true
            
            let gradientView = UIView()
            let gradientLayer = CAGradientLayer()
            
            gradientView.frame = CGRect(x: 0.0, y: (imageSize - releaseLabelGradientHeight), width: imageSize, height: releaseLabelGradientHeight)
            gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: imageSize, height: releaseLabelGradientHeight)
            
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.locations = [0.0, 0.45, 1.0]
            
            let bgColor = UIColor(red: 0.137, green: 0.137, blue: 0.215, alpha: 1.0)
            gradientLayer.colors = [
                bgColor.withAlphaComponent(0.0).cgColor,
                bgColor.withAlphaComponent(0.75).cgColor,
                bgColor.cgColor
            ]
            
            gradientView.layer.addSublayer(gradientLayer)
            self.posterImage.insertSubview(gradientView, at: 0)
        }
    }
    
    weak var movie: MovieObject? = nil {
        didSet {
            guard let movie = self.movie else {
                return
            }
            
            self.titleLabel.text = movie.title
            
            if let release = movie.release {
                self.releaseLabel.text = String(Calendar.current.component(.year, from: release))
            }
            
            self.overviewLabel.text = movie.overview
            if let posterData = movie.poster {
                self.posterImage.image = UIImage(data: posterData)
            }
        }
    }
    
}
