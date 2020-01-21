//
//  EmptyView.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 19/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class EmptyView: UIView {
    private var emptyImage = UIImageView()
    private var descriptionLabel = UILabel.init()
    private var margin: CGFloat = 16
    private var state: EmptyState?

    init() {
        super.init(frame: .zero)
        subViews()
        style()
        autolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeEmptyView(toState state: EmptyState) {
        DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
            self.state = state
            self.descriptionLabel.text = state.description
            if state == .loading, let path = state.imagePath {
                let images = self.emptyImage.generateImageSequence(withPath: path, andRange: 1...9)
                self.emptyImage.animationImages = images
                self.emptyImage.animationDuration = 4
                self.emptyImage.animationRepeatCount = -1
                self.emptyImage.startAnimating()
            } else {
                self.emptyImage.stopAnimating()
                guard let path = state.imagePath,
                      let img = UIImage.init(named: path)
                    else { return }
                self.emptyImage.image = img
            }
        }
    }
    
    private func subViews() {
        sv(emptyImage, descriptionLabel)
    }
    
    private func style() {
        let font = UIFont.boldSystemFont(ofSize: 18)
        descriptionLabel.font = font
        descriptionLabel.textColor = .textColor
        descriptionLabel.numberOfLines = -1
        descriptionLabel.textAlignment = .center
    }
    
    private func autolayout() {
        emptyImage.centerInContainer()
        descriptionLabel.leading(2%).trailing(2%)
        descriptionLabel.Top == emptyImage.Bottom + margin
    }
}
