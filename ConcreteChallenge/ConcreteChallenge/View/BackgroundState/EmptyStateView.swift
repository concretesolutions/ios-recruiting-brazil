//
//  EmptyStateView.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

protocol EmptyStateRetryDelegate {
    func executeRetryAction(_ sender: EmptyStateView)
}

class EmptyStateView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var retryButton: UIButton!

    public var retryDelegate: EmptyStateRetryDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        retryButton.layer.cornerRadius = 4
    }

    func set(with configuration: BackgroundStateViewModel) {
        imageView.image = UIImage(named: configuration.image.rawValue)
        titleLabel.text = configuration.title

        if configuration.subtitle.isEmpty {
            descriptionLabel.isHidden = true
        } else {
            descriptionLabel.isHidden = false
            descriptionLabel.text = configuration.subtitle
        }

        if configuration.retry.isEmpty {
            retryButton.isHidden = true
        } else {
            retryButton.isHidden = false
            retryButton.setTitle(configuration.retry, for: .normal)
        }
    }

    @IBAction func retryAction(_ sender: Any) {
        guard let delegate = self.retryDelegate else { return }
        delegate.executeRetryAction(self)
    }
}
