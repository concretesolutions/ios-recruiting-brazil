//
//  ErrorView.swift
//  Movs
//
//  Created by Adrian Almeida on 28/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class ErrorView: UIView {
    private lazy var imageView: UIImageView = UIImageView()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.textColor = .appBlackLight
        label.numberOfLines = 0

        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, title])
        stackView.axis = .vertical
        stackView.alignment = .center

        return stackView
    }()

    // MARK: - Constatns

    var image: UIImage {
        didSet {
            configuration.image = image
        }
    }

    var text: String {
        didSet {
            configuration.text = text
        }
    }

    var configuration: ErrorConfiguration {
        didSet {
            setConfiguration(configuration: configuration)
        }
    }

    // MARK: - Initializers

    init(configuration: ErrorConfiguration = ErrorConfiguration()) {
        self.image = configuration.image
        self.text = configuration.text
        self.configuration = configuration

        super.init(frame: .zero)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private functions

    private func setConfiguration(configuration: ErrorConfiguration) {
        if image != configuration.image {
            self.image = configuration.image
        }

        if text != configuration.text {
            self.text = configuration.text
        }

        setupLayout()
    }

    private func setupLayout() {
        imageView.image = image
        title.text = text

        addSubview(stackView, constraints: [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 128),
            imageView.widthAnchor.constraint(equalToConstant: 128)
        ])
    }
}
