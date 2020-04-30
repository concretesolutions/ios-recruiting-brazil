//
//  MovieDetailsHeaderView.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class MovieDetailsHeaderView: UICollectionReusableView {
    var bluredView: UIVisualEffectView!

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!

    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var directorJobLabel: UILabel!

    @IBOutlet weak var screenplayNameLabel: UILabel!
    @IBOutlet weak var screenplayJobLabel: UILabel!

    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        clipsToBounds = true
        backgroundColor = .clear

        setupBackgroundImage()
        setupCoverImage()
    }

    func setup(with sectionData: MovieDetailsHeaderSection) {
        if let posterUrl = sectionData.posterUrl {
            backgroundImageView.sd_setImage(
                with: posterUrl,
                placeholderImage: UIImage(named: "placeholder.png")
            )
            coverImageView.sd_setImage(
                with: posterUrl,
                placeholderImage: UIImage(named: "placeholder.png")
            )
        }

        genreLabel.text = sectionData.genres

        if let director = sectionData.director {
            directorNameLabel.text = director.name
            directorJobLabel.text = director.jobs
        }

        if let screenplayer = sectionData.screenplayer {
            screenplayNameLabel.text = screenplayer.name
            screenplayJobLabel.text = screenplayer.jobs
        }

        taglineLabel.text = sectionData.tagline

    }

    fileprivate func setupCoverImage() {
        coverImageView.clipsToBounds = true
        coverImageView.layer.shadowPath =
            UIBezierPath(roundedRect: coverImageView.bounds,
                         cornerRadius: coverImageView.layer.cornerRadius).cgPath
        coverImageView.layer.shadowColor = UIColor.black.cgColor
        coverImageView.layer.shadowOpacity = 0.5
        coverImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        coverImageView.layer.masksToBounds = false
        coverImageView.layer.shadowRadius = 10.0
    }

    fileprivate func setupBackgroundImage() {
        backgroundImageView.image = UIImage(named: "placeholder.png")
        backgroundImageView.fillSuperview()
        bluredView = backgroundImageView.blurred(style: .dark)
        bluredView.alpha = 0.9
    }

}
