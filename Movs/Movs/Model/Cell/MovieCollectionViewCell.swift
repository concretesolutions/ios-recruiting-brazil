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
    public var movie: Movie? {
        didSet {
            self.setImage()
            self.titleLabel.text = movie?.title
        }
    }
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.sd_setShowActivityIndicatorView(true)
        image.sd_setIndicatorStyle(.white)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var toggle: ToggleButton = {
        let toggle = FavoriteToggle()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
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
        self.addSubview(self.toggle)
        self.addSubview(self.containerView)
        self.addSubview(self.titleLabel)
    }
    
    func setupConstraints() {
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 3/2).isActive = true
        
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/5).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CGFloat(8)).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: CGFloat(-8)).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: CGFloat(-8)).isActive = true
        
        toggle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CGFloat(-8)).isActive = true
        toggle.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(8)).isActive = true
        toggle.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        toggle.widthAnchor.constraint(equalTo: toggle.heightAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        titleLabel.font = UIFont(name: "Futura", size: CGFloat(20))
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 3
        self.backgroundColor = .gray
    }
    
    func setImage() {
        if let movie = self.movie {
            let url = URL(string: TMDBManager.imageEndpoint + (movie.poster_path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""))
            self.image.sd_setImage(with: url)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: .zero)
        UIView.addGradient(toView: self.containerView)
    }
}
