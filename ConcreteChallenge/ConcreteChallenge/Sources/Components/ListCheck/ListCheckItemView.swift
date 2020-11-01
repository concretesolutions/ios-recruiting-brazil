//
//  ListCheckItemView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class ListCheckItemView: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)

        return label
    }()

    private lazy var value: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.textColor = .appYellowLight

        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, value, imageView])
        stackView.distribution = .fillProportionally
        stackView.spacing = 4

        return stackView
    }()

    // MARK: - Private constants

    private var viewModel: ListCheckItemViewModel {
        didSet {
            setupViewModel()
        }
    }

    // MARK: - Initializers

    init(viewModel: ListCheckItemViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Functions

    func update(viewModel new: ListCheckItemViewModel) {
        viewModel = new
    }

    private func setup() {
        setupLayout()
        setupViewModel()
    }

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])

        title.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private func setupViewModel() {
        if let title = viewModel.title {
            self.title.isHidden = false
            self.title.text = title
        } else {
            title.isHidden = true
        }

        if let value = viewModel.value {
            self.value.isHidden = false
            self.value.text = value
        } else {
            value.isHidden = true
        }

        if let icon = viewModel.icon {
            imageView.isHidden = false
            imageView.image = UIImage(assets: icon)
        } else {
            imageView.isHidden = true
        }
    }
}
