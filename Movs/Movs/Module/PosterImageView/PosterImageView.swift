//
//  PosterImageView.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class PosterImageView: UIView {

    private var loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var viewModel: PosterImageViewModel? {
        didSet {
            self.viewModel?.fetchPoster { posterImg in
                self.imageView.image = posterImg

                self.imageView.alpha = 0.0
                UIView.animate(withDuration: 0.5) {
                    self.loadingIndicator.stopAnimating()
                    self.imageView.alpha = 1.0
                }
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground
        
        let subviews = [self.loadingIndicator, self.imageView]
        UIView.translatesAutoresizingMaskIntoConstraintsToFalse(to: subviews)
        self.addSubviews(subviews)
        
        self.loadingIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
