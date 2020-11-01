//
//  HorizontalInfoListItemView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class HorizontalInfoListItemView: UIView {
    private lazy var imageView = UIImageView()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)

        return label
    }()

    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)

        return label
    }()

    private lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0

        return label
    }()

    // MARK: - Private constants

    private var viewModel: HorizontalInfoListViewModel {
        didSet {
            setupViewModel()
        }
    }

    // MARK: - Initializers

    init(viewModel: HorizontalInfoListViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        setupLayout()
        setupViewModel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Functions

    func update(viewModel new: HorizontalInfoListViewModel) {
        viewModel = new
    }

    // MARK: - Private functions

    private func setupLayout() {
        addSubview(imageView, constraints: [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])

        addSubview(title, constraints: [
            title.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12)
        ])

        addSubview(subtitle, constraints: [
            subtitle.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            subtitle.leadingAnchor.constraint(greaterThanOrEqualTo: title.trailingAnchor, constant: 4),
            subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])

        addSubview(descriptionText, constraints: [
            descriptionText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            descriptionText.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            descriptionText.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12)
        ])

        subtitle.setContentCompressionResistancePriority(.required, for: .horizontal)

        backgroundColor = .lightGray
    }

    private func setupViewModel() {
        imageView.kf.setImage(with: URL(string: viewModel.imageURL))

        title.text = viewModel.title

        subtitle.text = viewModel.subtitle

        descriptionText.text = viewModel.descriptionText
    }
}
