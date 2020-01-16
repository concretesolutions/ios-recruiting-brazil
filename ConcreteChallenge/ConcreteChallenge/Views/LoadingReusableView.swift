//
//  LoadingCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 15/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .medium)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.startAnimating()
        
        return loadingView
    }()
    
    func setup() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        self.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
