//
//  GalleryItemView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 26/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class GalleryItemView: UIView {

    // MARK: - Initializers

    public init() {
        super.init(frame: .zero)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private functions

    private func setupLayout() {
        backgroundColor = .red
    }
}
