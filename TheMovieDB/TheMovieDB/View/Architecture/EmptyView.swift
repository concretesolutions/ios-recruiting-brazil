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
        self.state = state
        descriptionLabel.text = state.description
        if state == .loading, let path = state.imagePath {
            let images = emptyImage.generateImageSequence(withPath: path, andRange: 1...9)
            emptyImage.animationImages = images
            emptyImage.animationDuration = 4
            emptyImage.animationRepeatCount = -1
            emptyImage.startAnimating()
        } else {
            emptyImage.stopAnimating()
            guard let path = state.imagePath,
                  let img = UIImage.init(named: path)
                else { return }
            emptyImage.image = img
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
