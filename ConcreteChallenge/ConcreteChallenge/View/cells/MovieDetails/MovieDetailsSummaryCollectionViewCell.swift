//
//  SummaryCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 26/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class MovieDetailsSummaryCollectionViewCell: UICollectionViewCell {
    weak var summaryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let titleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Avenir-Black", size: 17)!
        titleLabel.text = "Summary"
        titleLabel.textAlignment = .left
        
        let summaryLabel = UILabel(frame: .zero)
        self.contentView.addSubview(summaryLabel)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
//        let names = UIFont.fontNames(forFamilyName: "Avenir")
        summaryLabel.font = UIFont(name: "Avenir", size: 14)!
        summaryLabel.text = "Teste"
        summaryLabel.textAlignment = .left
        summaryLabel.numberOfLines = 0
        
        self.summaryLabel = summaryLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            summaryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            summaryLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
        
        self.layer.addBorder(edge: .bottom, color: UIColor.black.withAlphaComponent(0.1), thickness: 1)
    }
    
    
    func setup(with movieDetails: MovieDetails) {
        let attributedString = NSMutableAttributedString(string: movieDetails.overview)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        summaryLabel.attributedText = attributedString
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

//        self.summaryLabel.text = nil
    }
}
