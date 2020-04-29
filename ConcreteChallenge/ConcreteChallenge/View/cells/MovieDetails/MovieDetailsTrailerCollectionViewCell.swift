//
//  MovieDetailsTrailerCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 26/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class MovieDetailsTrailerCollectionViewCell: UICollectionViewCell {
    weak var titleLabel: UILabel!
    weak var imageView: UIImageView!
    
    private var videoUrl: URL!
    
    var calculatedHeight: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let titleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Avenir-Black", size: 17)!
        titleLabel.text = "Trailer"
        titleLabel.textAlignment = .left
        
        
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "placeholer.png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        self.imageView = imageView
        let tap = UITapGestureRecognizer(target: self, action: #selector(openUrl))
        self.imageView.addGestureRecognizer(tap)
        self.imageView.isUserInteractionEnabled = true
        
        let playImageView = UIImageView(frame: .zero)
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        playImageView.image = Constants.theme.playImage.mask(with: .white)
        playImageView.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(playImageView)
        
        let screenSize: CGRect = UIScreen.main.bounds
//        contentView.translatesAutoresizingMaskIntoConstraints = false
    
        
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalToConstant: (screenSize.width - 2 * Constants.theme.paddingHorizontal)),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 9.0/16),
            
            playImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            playImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            playImageView.widthAnchor.constraint(equalToConstant: 70),
            playImageView.heightAnchor.constraint(equalToConstant: 70),
            
        ])
        
        self.contentView.addBorders(edges: [.bottom], color: UIColor.black.withAlphaComponent(0.1), inset: -20, thickness: 1)
    }
    
    @objc private func openUrl() {
        UIApplication.shared.open(videoUrl)
    }
    
    
    func setup(with sectionData: MovieDetailsTrailerSection) {
        self.videoUrl = sectionData.videoUrl
        
        imageView.sd_setImage(
            with: sectionData.imageUrl,
            placeholderImage: UIImage(named: "placeholder.png")
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        fatalError("Interface Builder is not supported!")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        fatalError("Interface Builder is not supported!")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.calculatedHeight = false
    }

    
    
    override func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority) -> CGSize {

        var targetSize = targetSize
        
        if !calculatedHeight {
            calculatedHeight = true
            targetSize.height = 1000
            targetSize = super.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            
        }
        return targetSize
    }
}
