//
//  GalleryItemView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GalleryItemView: UIView, ViewCode {

    // MARK: - Initializers

    public init() {
        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - ViewCode conforms

    func setupHierarchy() { }

    func setupConstraints() { }

    func setupConfigurations() {
        backgroundColor = .red
    }
}
