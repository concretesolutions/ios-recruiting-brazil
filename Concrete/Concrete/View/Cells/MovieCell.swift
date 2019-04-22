//
//  MovieCell.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var imageViewShadow: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonStar: UIButton!

    func setCellData(cellData: MovieViewModel) {
        imageViewMovie.layer.sublayers = nil
        imageViewMovie.image = nil
        labelTitle.text = ""
        buttonStar.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)

        if let title = cellData.title {
            labelTitle.text = title
        }

        if let image = cellData.image {
            print(ConstUrl.urlImage(image: image))
            imageViewMovie.sd_setImage(with:
                URL(string: ConstUrl.urlImage(image: image)), placeholderImage: UIImage(named: ""))
        }

        setShadow()
        checkBookmark(cellData: cellData)

        imageViewMovie.layer.cornerRadius = 8
        imageViewMovie.clipsToBounds = true

        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor,
                           UIColor.clear.cgColor,
                           UIColor(red: 0/255.0,
                                   green: 0/255.0,
                                   blue: 0/255.0,
                                   alpha: 0.8).cgColor]
        gradient.locations = [0.0, 0.4, 0.7]
        imageViewMovie.layer.insertSublayer(gradient, at: 0)
    }

    private func checkBookmark(cellData: MovieViewModel) {
        if let idMovie = cellData.idMovie {
            if DBManager.sharedInstance.checkBookmarkedItemFromKey(pKey: idMovie) {
                buttonStar.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            }
        }
    }

    private func setShadow() {
        imageViewShadow.backgroundColor = UIColor.black
        imageViewShadow.layer.cornerRadius = 8
        imageViewShadow.layer.shadowColor = UIColor.black.cgColor
        imageViewShadow.layer.shadowOffset = CGSize(width: 3, height: 3)
        imageViewShadow.layer.shadowOpacity = 0.7
        imageViewShadow.layer.shadowRadius = 3.0
    }
}
