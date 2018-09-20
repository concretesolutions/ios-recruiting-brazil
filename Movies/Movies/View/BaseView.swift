//
//  BaseView.swift
//  Movies
//
//  Created by Jonathan Martins on 19/09/2018.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    // The views feedback
    let feedbackMessage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .appColor
        label.textAlignment = .center
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // The loader
    let loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.color = .appColor
        loading.hidesWhenStopped = true
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    // Adds the constraints to this view
    func setupConstraints(){
        self.addSubview(loading)
        self.addSubview(feedbackMessage)
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            feedbackMessage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/1.5),
            feedbackMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            feedbackMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appColor
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

