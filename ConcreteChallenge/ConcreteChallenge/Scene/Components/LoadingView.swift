//
//  LoadingView.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 23/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class LoadingView: UIView, ViewCode {

    lazy var blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    lazy var activityIndicator = UIActivityIndicatorView(style: .gray)

    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setupSubviews() {
        addSubview(blurEffectView)

        blurEffectView.contentView.addSubview(activityIndicator)
    }

    func setupLayout() {
        blurEffectView.fillToSuperview()

        activityIndicator
            .anchor(centerX: blurEffectView.contentView.centerXAnchor)
            .anchor(centerY: blurEffectView.contentView.centerYAnchor)
    }

    func start() {
        activityIndicator.startAnimating()
    }

    func stop() {
        activityIndicator.stopAnimating()
    }
}
