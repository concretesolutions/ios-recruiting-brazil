//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Julio Brazil on 22/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell, CodeView {
    public var movie: CodableMovie? {
        didSet {
            self.setImage()
            self.titleLabel.text = movie?.title
        }
    }
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.sd_setShowActivityIndicatorView(true)
        image.sd_setIndicatorStyle(.white)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func buildViewHierarchy() {
        self.addSubview(self.image)
        self.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 3/2).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .black
    }
    
    func setImage() {
        if let movie = self.movie {
            let url = URL(string: TMDBManager.imageEndpoint + (movie.poster_path?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""))
            self.image.sd_setImage(with: url)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .zero)
    }

}
