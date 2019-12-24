//
//  ExceptionView.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 20/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import SnapKit
import UIKit

final class ExceptionView: UIView {

    // MARK: - Subviews

    private lazy var mainStack: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 10.0
        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.tintColor = .systemIndigo
        return view
    }()

    private lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()
    }

    convenience init(frame: CGRect = .zero, imageSystemName systemName: String, text: String) {
        self.init(frame: frame)
        self.imageView.image = UIImage(systemName: systemName)
        self.textLabel.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExceptionView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.mainStack)
        self.mainStack.addArrangedSubview(self.imageView)
        self.mainStack.addArrangedSubview(self.textLabel)
    }

    func setupContraints() {

        // mainStack

        self.mainStack.snp.makeConstraints { maker in
            maker.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
        }

        // imageView

        self.imageView.snp.makeConstraints { maker in
            maker.width.height.equalTo(75)
        }

        // textLabel

        self.textLabel.snp.makeConstraints { maker in
            maker.width.equalTo(self).multipliedBy(0.6)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}

// MARK: - Standard Exception views

extension ExceptionView {
    static let error = ExceptionView(imageSystemName: "xmark.circle.fill", text: "An error occurred. Please try again later.")

    static let emptySearch = ExceptionView(imageSystemName: "magnifyingglass.circle.fill", text: "No matching movie found for this search.")

    static let emptyFavorites = ExceptionView(imageSystemName: "heart.circle.fill", text: "You don't have any favorite movie yet.")
}
