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

    var calculatedHeight: Bool = false

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

        let screenSize: CGRect = UIScreen.main.bounds
//        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Auto resize width anchor
            contentView.widthAnchor.constraint(equalToConstant: (screenSize.width - 2 * Theme.paddingHorizontal)),
            // Title constraints
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            // Title constraints
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            summaryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            summaryLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])

        self.contentView.addBorders(edges: [.bottom], color: UIColor.black.withAlphaComponent(0.1), inset: -20, thickness: 1)
    }

    func setup(with sectionData: MovieDetailsSummarySection) {
        let attributedString = NSMutableAttributedString(string: sectionData.summary)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
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
        self.summaryLabel.attributedText = nil
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
