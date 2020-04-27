//
//  MovieDetailsTitleCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 26/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class MovieDetailsTitleCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var originalTitleDuration: UILabel!
    
    private var sizingOnlyWidthConstraint: NSLayoutConstraint? = nil
    
    var isHeightCalculated: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive = true
        titleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Avenir-Black", size: 28)!
        titleLabel.text = "Summary"
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        originalTitleDuration = UILabel(frame: .zero)
        self.contentView.addSubview(originalTitleDuration)
        originalTitleDuration.translatesAutoresizingMaskIntoConstraints = false
//        let names = UIFont.fontNames(forFamilyName: "Avenir")
        originalTitleDuration.font = UIFont(name: "Avenir", size: 14)!
        originalTitleDuration.text = "Teste"
        originalTitleDuration.textAlignment = .left
        originalTitleDuration.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            originalTitleDuration.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            originalTitleDuration.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            originalTitleDuration.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            originalTitleDuration.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ])
        self.contentView.addBorders(edges: [.bottom], color: UIColor.black.withAlphaComponent(0.1), inset: 0, thickness: 1)
    }
    
    func setup(with movieDetails: MovieDetails) {
        let year = String(movieDetails.releaseDate.prefix(4))
        titleLabel.text = "\(movieDetails.title) (\(year))"
        
        var originalTitleDurationText: [String] = []
        
        if movieDetails.originalTitle != movieDetails.title {
            originalTitleDurationText.append("Original title: \(movieDetails.originalTitle)")
        }
        
        let runtime = Double(movieDetails.runtime!) * 60
        
        if runtime > 0 {
            let formated = runtime.format(using: [.hour, .minute, .second])!
            originalTitleDurationText.append(formated)
        }
        
        originalTitleDuration.text = originalTitleDurationText.joined(separator: " | ")
        
        
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
        
        self.titleLabel.text = nil
        self.originalTitleDuration.text = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}
