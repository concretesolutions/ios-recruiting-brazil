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
    var ratingLabel: UILabel!

    private var sizingOnlyWidthConstraint: NSLayoutConstraint?

    var calculatedHeight: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Theme.sectionTitleFont
        titleLabel.text = "Summary"
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0

        originalTitleDuration = UILabel(frame: .zero)
        self.contentView.addSubview(originalTitleDuration)
        originalTitleDuration.translatesAutoresizingMaskIntoConstraints = false
        originalTitleDuration.font = Theme.sectionBodyFont
        originalTitleDuration.text = "Teste"
        originalTitleDuration.textAlignment = .left
        originalTitleDuration.numberOfLines = 0

        // Rating
        let ratingContainer = UIView(frame: .zero)
        ratingContainer.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(ratingContainer)

        let starImageView = UIImageView(frame: .zero)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.image = Theme.starImage.mask(with: UIColor(asset: .brand))
        starImageView.contentMode = .scaleAspectFit
        ratingContainer.addSubview(starImageView)

        ratingLabel = UILabel(frame: .zero)
        self.contentView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = Theme.sectionTitleFont.withSize(16)
        ratingLabel.text = "5.0"
        ratingLabel.textAlignment = .left

        let screenSize: CGRect = UIScreen.main.bounds

        NSLayoutConstraint.activate([
            // Auto resize width anchor
            contentView.widthAnchor.constraint(equalToConstant: (screenSize.width - 2 * Theme.paddingHorizontal)),

            // Orignal title constraints
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            // Orignal title constraints
            originalTitleDuration.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            originalTitleDuration.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            originalTitleDuration.trailingAnchor.constraint(equalTo: ratingContainer.leadingAnchor, constant: -8),
            originalTitleDuration.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),

            // Rating Container
            ratingContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            ratingContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ratingContainer.widthAnchor.constraint(equalToConstant: 50),
            ratingContainer.heightAnchor.constraint(equalToConstant: 18),

            // Rating Star
            starImageView.topAnchor.constraint(equalTo: ratingContainer.topAnchor),
            starImageView.leadingAnchor.constraint(equalTo: ratingContainer.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 18),
            starImageView.heightAnchor.constraint(equalToConstant: 18),

            ratingLabel.topAnchor.constraint(equalTo: ratingContainer.topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingContainer.trailingAnchor)
        ])

        self.contentView.addBorders(edges: [.bottom], color: UIColor.black.withAlphaComponent(0.1), inset: -20, thickness: 1)    }

    func setup(with sectionData: MovieDetailTitleSection) {
        titleLabel.text = sectionData.title
        originalTitleDuration.text = sectionData.subtitle
        ratingLabel.text = sectionData.rating
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
